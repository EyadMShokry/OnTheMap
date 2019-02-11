//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/9/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var studentsInformationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        studentsInformationTableView.dataSource = self
        studentsInformationTableView.delegate = self
        performUIUpdatesOnMain {
            self.studentsInformationTableView.reloadData()
        }
        print("Number of students is \(StudentsLocation.shared.studentsInformation.count)")
    }
    
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsLocation.shared.studentsInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentInformationCell", for: indexPath) as! StudentInformationTableViewCell
        cell.configureCellWith(StudentsLocation.shared.studentsInformation[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delegate?.didSelectLocation(info: StudentsLocation.shared.studentsInformation[indexPath.row])
        openWithSafari(StudentsLocation.shared.studentsInformation[indexPath.row].mediaURL)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

