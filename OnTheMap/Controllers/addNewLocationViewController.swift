//
//  addNewLocationViewController.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/8/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit
import CoreLocation

class addNewLocationViewController: UIViewController {
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    var locationID: String?
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavBar()
        activityIndecator.isHidden = true
    }

    @IBAction func onClickFindLocationButton(_ sender: UIButton) {
        activityIndecator.isHidden = false
        
        let location = locationTextField.text!
        let link = websiteTextField.text!
        
        if location.isEmpty || link.isEmpty {
            raiseAlertView(withMessage: "Location and Website are required")
            return
        }
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
            raiseAlertView(withMessage: "Invalid Link")
            return
        }
        geocode(location: location)
    }
    
    private func geocode(location: String) {
        enableControllers(false)
        activityIndecator.startAnimating()
        geocoder.geocodeAddressString(location) { (placemarkers, error) in
            self.enableControllers(true)
            self.performUIUpdatesOnMain {
                self.activityIndecator.stopAnimating()
            }
            
            if let error = error {
                self.raiseAlertView(withTitle: "Error", withMessage: "Unable to Forward Geocode Address (\(error))")
            } else {
                var location: CLLocation?
                
                if let placemarks = placemarkers, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    self.syncStudentLocation(location.coordinate)
                } else {
                    self.raiseAlertView(withMessage: "No Matching Location Found")
                }
            }
        }
    }
    
    private func syncStudentLocation(_ coordinate: CLLocationCoordinate2D) {
        self.enableControllers(true)
        
        let finishLocationVC = storyboard?.instantiateViewController(withIdentifier: "FinishLocation") as! FinishLocationViewController
        finishLocationVC.studentInformation = buildStudentInfo(coordinate)
        navigationController?.pushViewController(finishLocationVC, animated: true)
        
    }
    
    private func buildStudentInfo(_ coordinate: CLLocationCoordinate2D) -> StudentInformation {
        let nameComponents = Client.shared().userName.components(separatedBy: " ")
        let firstName = nameComponents.first ?? ""
        let lastName = nameComponents.last ?? ""
        
        var studentInfo = [
            "uniqueKey": Client.shared().userKey,
            "firstName": firstName,
            "lastName": lastName,
            "mapString": locationTextField.text!,
            "mediaURL": websiteTextField.text!,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            ] as [String: AnyObject]
        
        if let locationID = locationID {
            studentInfo["objectId"] = locationID as AnyObject
        }
        return StudentInformation(studentInfo)
    }
    
    private func enableControllers(_ enable: Bool) {
        self.enableUI(views: locationTextField, websiteTextField, findLocationButton, enable: enable)
    }

    private func setUpNavBar(){
        self.navigationItem.title = "Add Location"
        let backButton = UIBarButtonItem()
        backButton.title = "CANCEL"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
