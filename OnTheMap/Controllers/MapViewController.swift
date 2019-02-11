//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/8/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStarted), name: .reloadStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCompleted), name: .reloadCompleted, object: nil)
        
        mapView.delegate = self
        //loadUserInfo()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadStarted() {
        performUIUpdatesOnMain {
            self.activityIndecator.startAnimating()
            self.mapView.alpha = 0.5
        }
    }
    
    @objc func reloadCompleted() {
        performUIUpdatesOnMain {
            self.activityIndecator.stopAnimating()
            self.mapView.alpha = 1
            self.showStudentsInformation(StudentsLocation.shared.studentsInformation)
        }
    }
    
    private func showStudentsInformation(_ studentsInformation: [StudentInformation]) {
        mapView.removeAnnotations(mapView.annotations)
        for info in studentsInformation where info.latitude != 0 && info.longitude != 0 {
            let annotation = MKPointAnnotation()
            annotation.title = info.labelName
            annotation.subtitle = info.mediaURL
            annotation.coordinate = CLLocationCoordinate2DMake(info.latitude, info.longitude)
            mapView.addAnnotation(annotation)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    private func loadUserInfo() {
        _ = Client.shared().studentInfo(completionHandler: { (studentInfo, error) in
            if let error = error {
                self.raiseAlertView(withTitle: "Error", withMessage: error.localizedDescription)
                return
            }
            Client.shared().userName = studentInfo?.name ?? ""
        })
    }
    
    
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            guard let subtitle = view.annotation?.subtitle else  {
                self.raiseAlertView(withMessage: "No link defined.")
                return
            }
            guard let link = subtitle else {
                self.raiseAlertView(withMessage: "No link defined.")
                return
            }
            openWithSafari(link)
        }
    }
    
}
