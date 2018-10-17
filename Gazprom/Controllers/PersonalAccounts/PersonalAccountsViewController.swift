//
//  PersonalAccountsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

struct personalAccountsModel {
    var
    ls: String?,
    city: String?,
    address: String?,
    numberBuild: Int?,
    numberFlat: Int?
    
}
var arrayOfAccounts = [personalAccountsModel]()


class PersonalAccountsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let personal1 = personalAccountsModel(ls: "9999999", city: "Bishkek", address: "Panfilova", numberBuild: 143, numberFlat: 12)
        let personal2 = personalAccountsModel(ls: "7777777", city: "New York", address: "Lincoln str", numberBuild: 22, numberFlat: 123)
        let personal3 = personalAccountsModel(ls: "1111111", city: "London", address: "Baker str", numberBuild: 37, numberFlat: 12)
        
        arrayOfAccounts.append(personal1)
        arrayOfAccounts.append(personal2)
        arrayOfAccounts.append(personal3)
    }
    


}

extension PersonalAccountsViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAccounts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonalAccountsTableViewCell
        
        cell.label.text = arrayOfAccounts[indexPath.row].ls
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        
        if let city = arrayOfAccounts[indexPath.row].city,
            let address = arrayOfAccounts[indexPath.row].address,
            let build = arrayOfAccounts[indexPath.row].numberBuild,
            let flat = arrayOfAccounts[indexPath.row].numberFlat,
            let ls = arrayOfAccounts[indexPath.row].ls
        {
            let fullAddress = city + ", " + address + " \(build)" + "-\(flat)"
            
            vc.accountNumberLbl = ls
            vc.addressLbl = fullAddress
            vc.arrayOfAccounts = arrayOfAccounts
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
}


