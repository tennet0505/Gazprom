//
//  PersonalAccountsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import SVProgressHUD

struct personalAccountsModel {
    var
    ls: String?,
    city: String?,
    address: String?,
    numberBuild: Int?,
    numberFlat: Int?
    
}


class PersonalAccountsViewController: UIViewController {
    
    var arrayOfAccounts = [personalAccountsModel]()
    
    let personal1 = personalAccountsModel(ls: "92324999-11", city: "Bishkek", address: "Panfilova", numberBuild: 143, numberFlat: 12)
    let personal2 = personalAccountsModel(ls: "4341777-22", city: "New York", address: "Lincoln str", numberBuild: 22, numberFlat: 123)
    let personal3 = personalAccountsModel(ls: "1121311-33", city: "London", address: "Baker str", numberBuild: 37, numberFlat: 66)
    let personal4 = personalAccountsModel(ls: "11212351-33", city: "Бишкек", address: "Советская", numberBuild: 123, numberFlat: 34)
    let personal5 = personalAccountsModel(ls: "2434311-33", city: "Токмак", address: "Чуй", numberBuild: 221, numberFlat: 3)
    var personalNew = personalAccountsModel()
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfAccounts = [personal1, personal2, personal3, personal4, personal5]
      
    }
    
    @IBAction func addNewBillButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewPersonalAccountsViewController") as! NewPersonalAccountsViewController
        vc.arrayOfAccounts = arrayOfAccounts
        
        navigationController?.pushViewController(vc, animated: true)
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


