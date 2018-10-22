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
       
//        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PersonalAccountsViewController") as! PersonalAccountsViewController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = vc
//
//        let enterAlert = UIAlertController(title: "Удалить лицевой счет?", message: "", preferredStyle: .alert
//        )
//        let action1 = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
//            print("delete")
////            self.deleteAccount(id: idAccount)
////            self.arrayOfAccounts.remove(at: indexPath.row)
////            self.tableView.reloadData()
//        })
//        let action2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//
//        enterAlert.addAction(action1)
//        enterAlert.addAction(action2)
//
//        vc.present(enterAlert, animated: true, completion: nil)
        
        print("Tap delete")
    }
}
