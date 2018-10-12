//
//  PersonalAccountsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

var arrayOfAccounts = ["123456787654","34567898765","34567890987"]

class PersonalAccountsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


}

extension PersonalAccountsViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonalAccountsTableViewCell
        
        cell.label.text = arrayOfAccounts[indexPath.row]
        
        return cell
    }
    
   
}

