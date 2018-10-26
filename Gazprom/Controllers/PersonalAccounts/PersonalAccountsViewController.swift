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

    func deleteAccount(id: Int){
        SVProgressHUD.show()
        client.deletePersonal(id: id, successHandler: { () in
            print("delete account # \(id)")
            SVProgressHUD.dismiss()
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
        
       addNewAccount()
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
        if let idAcc = arrayOfAccounts[indexPath.row].id{
            cell.idAccount = idAcc
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            if let accountNumber = arrayOfAccounts[indexPath.row].account,
//                let idAccount = arrayOfAccounts[indexPath.row].id{
//                let enterAlert = UIAlertController(title: "Вы хотите удалить лицевой счет: \(accountNumber)?", message: "", preferredStyle: .alert
//                )
//
//                let action1 = UIAlertAction(title: "Удалить", style: .default) { (action) in
//                    self.deleteAccount(id: idAccount)
//                    self.arrayOfAccounts.remove(at: indexPath.row)
//                    self.tableView.reloadData()
//                }
//                let action2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//
//                enterAlert.addAction(action1)
//                enterAlert.addAction(action2)
//
//                present(enterAlert, animated: true, completion: nil)
//
//            }
        }
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let NewButton = UITableViewRowAction(style: .default, title: "Добавить") { (action, indexPath) in
            
            print("Add new Account")
            if let id = self.arrayOfAccounts[indexPath.row].id{
            self.addNewBill(id: id)
            }
        }
        let DeleteButton = UITableViewRowAction(style: .default, title: " Удалить") { (action, indexPath) in
            print("Delete new Account")
            if let accountNumber = self.arrayOfAccounts[indexPath.row].account,
                let idAccount = self.arrayOfAccounts[indexPath.row].id{
                let enterAlert = UIAlertController(title: "Вы хотите удалить лицевой счет: \(accountNumber)?", message: "", preferredStyle: .alert
                )
                
                let action1 = UIAlertAction(title: "Удалить", style: .default) { (action) in
                    self.deleteAccount(id: idAccount)
                    self.arrayOfAccounts.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
                let action2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                
                enterAlert.addAction(action1)
                enterAlert.addAction(action2)
                
                self.present(enterAlert, animated: true, completion: nil)
                
            }
        }
         NewButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return[DeleteButton,NewButton]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        
        if let city = arrayOfAccounts[indexPath.row].city,
            let address = arrayOfAccounts[indexPath.row].address,
            let build = arrayOfAccounts[indexPath.row].house_number,
            let flat = arrayOfAccounts[indexPath.row].flat_number,
            let ls = arrayOfAccounts[indexPath.row].account,
            let id = arrayOfAccounts[indexPath.row].id

        {
            let fullAddress = city + ", " + address + " \(build)" + "-\(flat)"
            
            vc.accountNumberLbl = "\(ls)"
            vc.addressLbl = fullAddress
          //  vc.arrayOfAccounts = arrayOfAccounts
            vc.indexAccount = indexPath.row
            vc.idAccount = id
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addNewAccount() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewPersonalAccountsViewController") as! NewPersonalAccountsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    func addNewBill(id: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewBillViewController") as! NewBillViewController
        vc.idAccount = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
