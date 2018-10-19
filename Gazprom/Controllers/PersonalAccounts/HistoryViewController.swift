//
//  HistoryViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/17/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var accountNumberLbl = ""
    var addressLbl = ""
    
   
    
    var arrayOfAccounts = [PersonalModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountNumberLabel.text = accountNumberLbl
        addressLabel.text = addressLbl
      
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewBillViewController") as! NewBillViewController
        
        vc.label = accountNumberLbl
        self.navigationController?.pushViewController(vc, animated: false)
       
    
    }
    
   
}
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAccounts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AccountsTableViewCell
        
        cell.labelDate.text = "must be date of bill"
        cell.labelBill.text = "must be bill"
        
        return cell
    }
   
  

    
}
