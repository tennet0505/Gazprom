//
//  HistoryViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/17/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class HistoryViewController: UIViewController {

    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var accountNumberLbl = ""
    var addressLbl = ""
    var indexAccount = 0
    let client = ApiClient()
    let reloadVC = PersonalAccountsViewController()
    var idAccount = 0
    var lastIndication = 0.0
    
    let alertController = UIAlertController(title: nil, message: "Удаление лицевого счета...", preferredStyle: .alert)
    let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
   
    
    var arrayOfAccounts = [PersonalModel]()
    var Indications = [IndicationModel]()
  //  var accountPersonal = PersonalModel()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getIndicationsl()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountNumberLabel.text = accountNumberLbl
        addressLabel.text = addressLbl
      
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewBillViewController") as! NewBillViewController
        
        vc.label = accountNumberLbl
        vc.idAccount = idAccount
        
        SVProgressHUD.dismiss()

        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let Account = arrayOfAccounts[indexAccount]
        
        if let accountId = Account.id, let account = Account.account{
            let enterAlert = UIAlertController(title: "Вы хотите удалить лицевой счет: \(account)?", message: "", preferredStyle: .alert
            )
            
            let action1 = UIAlertAction(title: "Удалить", style: .default) { (action) in
                self.deleteAccount(id: accountId)
                self.arrayOfAccounts.remove(at: self.indexAccount)
               
                self.loaderAlert()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self.spinnerIndicator.stopAnimating()
                    self.alertController.dismiss(animated: true, completion: nil)
                  
                    self.navigationController?.popViewController(animated: false)
                }
               
            }
            let action2 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            enterAlert.addAction(action1)
            enterAlert.addAction(action2)
            
            present(enterAlert, animated: true, completion: nil)
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
    func getIndicationsl() {
        SVProgressHUD.show()
        Indications.removeAll()
        UserDefaults.standard.set(0.0, forKey: "lastIndication")
        client.getIndications(url:"personal_accounts/\(idAccount)",
            successHandler: { (array) in
                
                if let array = array.meter_reading{
                    self.Indications = array
                    print(self.idAccount)
                }
                if self.Indications.count > 0{
                    self.Indications.reverse()
                    if let indication = self.Indications[0].indication{
                        UserDefaults.standard.set(indication, forKey: "lastIndication")
                    }}
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
                
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Indications.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AccountsTableViewCell
      
        if let dateIndication = Indications[indexPath.row].created_at,
            let indication = Indications[indexPath.row].indication {
                cell.labelDate.text = "\(dateIndication)"
                cell.labelBill.text = "\(indication)"
        }
        return cell
    }
   
    func loaderAlert(){
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 100)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
    }
  
}
