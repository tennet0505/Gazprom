//
//  PersonalAccountsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire


class PersonalAccountsViewController: UIViewController {
    
    var arrayOfAccounts = [PersonalModel]()
    let client = ApiClient()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPersonal()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    func getPersonal() {
        SVProgressHUD.show()
        
        client.getPersonal(successHandler: { (value) in
            
            let array = value
            for personal in array {
                self.arrayOfAccounts.append(personal)
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            print(self.arrayOfAccounts)
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func addNewBillButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewPersonalAccountsViewController") as! NewPersonalAccountsViewController
        // vc.arrayOfAccounts = arrayOfAccounts
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension PersonalAccountsViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAccounts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonalAccountsTableViewCell
        
        cell.label.text = arrayOfAccounts[indexPath.row].address
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        
        if let city = arrayOfAccounts[indexPath.row].city,
            let address = arrayOfAccounts[indexPath.row].address,
            let build = arrayOfAccounts[indexPath.row].house_number,
            let flat = arrayOfAccounts[indexPath.row].flat_number,
            let ls = arrayOfAccounts[indexPath.row].account
        {
            let fullAddress = city + ", " + address + " \(build)" + "-\(flat)"
            
            vc.accountNumberLbl = "\(ls)"
            vc.addressLbl = fullAddress
            vc.arrayOfAccounts = arrayOfAccounts
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//            if self.personal.count > 0{
//                self.fullAddress = self.personal[0].city! + ", " + self.personal[0].address! + " " + self.personal[0].house_number! + "-" + self.personal[0].flat_number!
//                self.adressTextFields.text = self.fullAddress
//                if let account = self.personal[0].account{
//                    self.nameTextField.text = "\(String(account))"
//                }}
