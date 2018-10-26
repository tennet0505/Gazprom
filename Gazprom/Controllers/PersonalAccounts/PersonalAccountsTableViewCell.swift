//
//  PersonalAccountsTableViewCell.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class PersonalAccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    var idAccount: Int = 0

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }

    @IBAction func deleteButton(_ sender: UIButton) {
       
        print("Tap delete")
    }
}
