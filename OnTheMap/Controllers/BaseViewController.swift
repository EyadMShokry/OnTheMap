//
//  BaseViewController.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/8/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit

class BaseViewController: UITabBarController {

    @IBOutlet weak var addNewLocationButton: UIBarButtonItem!
    @IBOutlet weak var refreshMapButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(loadStudentsInformation), name: .reload, object: nil)
        loadStudentsInformation()

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    @IBAction func onClickLogoutButton(_ sender: Any) {
        Client.shared().logout { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.raiseAlertView(withTitle: "Error", withMessage: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onClickRefreshMapButton(_ sender: Any) {
        loadStudentsInformation()
        
    }
    
    @IBAction func onClickAddLocationButton(_ sender: Any) {
        enableControllers(false)
        Client.shared().studentInformation { (studentInformation, error) in
            if let error = error {
                self.raiseAlertView(withTitle: "Error fetching student location", withMessage: error.localizedDescription)
            } else if let studentInformation = studentInformation {
                let msg = "User \"\(studentInformation.labelName)\" has already posted a Student Location. Whould you like to Overwrite it?"
                self.showConfermationAlert(withMessage: msg, actionTitle: "Overwrite", action: {
                    self.showAddNewLocationView(studentLocationID: studentInformation.locationID)
                })
            } else {
                self.performUIUpdatesOnMain {
                    self.showAddNewLocationView()
                }
            }
            self.enableControllers(true)
        }

    }
    
    //Error Here
    @objc private func loadStudentsInformation() {
        NotificationCenter.default.post(name: .reloadStarted, object: nil)
        Client.shared().studentsInformation { (studentsInformation, error) in
            if let error = error {
                self.raiseAlertView(withTitle: "Error", withMessage: error.localizedDescription)
                NotificationCenter.default.post(name: .reloadCompleted, object: nil)
                return
            }
            if let studentsInformation = studentsInformation {
                StudentsLocation.shared.studentsInformation = studentsInformation
                print("------ studentsInformation comes correctly -------")
            }
            NotificationCenter.default.post(name: .reloadCompleted, object: nil)
        }
    }
    
    
    private func enableControllers(_ enable: Bool) {
        performUIUpdatesOnMain {
            self.logoutButton.isEnabled = enable
            self.refreshMapButton.isEnabled = enable
            self.addNewLocationButton.isEnabled = enable
        }
    }
    
    private func showAddNewLocationView(studentLocationID: String? = nil) {
        let addNewLocationVC = storyboard?.instantiateViewController(withIdentifier: "addNewLocation") as! addNewLocationViewController
        addNewLocationVC.locationID = studentLocationID
        navigationController?.pushViewController(addNewLocationVC, animated: true)
    }
}


