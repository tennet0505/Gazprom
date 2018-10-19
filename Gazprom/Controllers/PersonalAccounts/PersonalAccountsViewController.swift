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
        
        getPersonal()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func getPersonal() {
        SVProgressHUD.show()
        arrayOfAccounts.removeAll()
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
    
    func reloadController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PersonalAccountsViewController") as! PersonalAccountsViewController
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func addNewBillButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewPersonalAccountsViewController") as! NewPersonalAccountsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension PersonalAccountsViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAccounts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonalAccountsTableViewCell
        if let account = arrayOfAccounts[indexPath.row].account{
            cell.label.text = "\(account)"
        }
       
        
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
