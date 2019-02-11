//
//  StudentInformationTableViewCell.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/9/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit

class StudentInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentUrlLabel: UILabel!
    
    func configureCellWith(_ info: StudentInformation) {
        studentNameLabel.text = info.labelName
        studentUrlLabel.text = info.mediaURL
    }
}
