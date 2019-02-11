//
//  FinishLocationViewController.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/10/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FinishLocationViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    var studentInformation: StudentInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        if let studentLocation = studentInformation {
            let location = Location(
                objectId: "",
                uniqueKey: nil,
                firstName: studentLocation.firstName,
                lastName: studentLocation.lastName,
                mapString: studentLocation.mapString,
                mediaURL: studentLocation.mediaURL,
                latitude: studentLocation.latitude,
                longitude: studentLocation.longitude,
                createdAt: "",
                updatedAt: ""
            )
            showLocations(location: location)
        }
    }
    
    private func showLocations(location: Location) {
        mapView.removeAnnotations(mapView.annotations)
        if let coordinate = extractCoordinate(location: location) {
            let annotation = MKPointAnnotation()
            annotation.title = location.locationLabel
            annotation.subtitle = location.mediaURL ?? ""
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    private func extractCoordinate(location: Location) -> CLLocationCoordinate2D? {
        if let lat = location.latitude, let lon = location.longitude {
            return CLLocationCoordinate2DMake(lat, lon)
        }
        return nil
    }

    
    @IBAction func onClickFinishButton(_ sender: UIButton) {
        if let studentLocation = studentInformation {
            showNetworkOperation(true)
            if studentLocation.locationID == nil {
                // POST
                Client.shared().postStudentLocation(info: studentLocation, completionHandler: { (success, error) in
                    self.showNetworkOperation(false)
                    self.handleSyncLocationResponse(error: error)
                })
            } else {
                // PUT
                Client.shared().updateStudentLocation(info: studentLocation, completionHandler: { (success, error) in
                    self.showNetworkOperation(false)
                    self.handleSyncLocationResponse(error: error)
                })
            }
        }
    }
    
    private func showNetworkOperation(_ show: Bool) {
        performUIUpdatesOnMain {
            self.finishButton.isEnabled = !show
            self.mapView.alpha = show ? 0.5 : 1
            show ? self.activityIndecator.startAnimating() : self.activityIndecator.stopAnimating()
        }
    }

    private func handleSyncLocationResponse(error: NSError?) {
        if let error = error {
            self.raiseAlertView(withTitle: "Error", withMessage: error.localizedDescription)
        } else {
            self.raiseAlertView(withTitle: "Success", withMessage: "Student Location updated!", action: {
                self.navigationController?.popToRootViewController(animated: true)
                NotificationCenter.default.post(name: .reload, object: nil)
            })
        }
    }

}
