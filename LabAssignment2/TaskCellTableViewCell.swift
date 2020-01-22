//
//  TaskCellTableViewCell.swift
//  LabAssignment2
//
//  Created by Sandeep Jangra on 2020-01-21.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class TaskCellTableViewCell: UITableViewCell {

      @IBOutlet weak var completedIMG: UIButton!
         @IBOutlet weak var titleLbl: UILabel!
         @IBOutlet weak var DaysLbl: UILabel!
         
         
         
         
         override func awakeFromNib() {
             super.awakeFromNib()
             
         }

         override func setSelected(_ selected: Bool, animated: Bool) {
             super.setSelected(selected, animated: animated)

         }


}
