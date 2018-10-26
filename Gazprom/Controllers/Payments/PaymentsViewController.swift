//
//  PaymentsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD


class PaymentsViewController: UIViewController {

    let serverUrl = "https://puppit.spalmalo.com"
    var arrayOfpayments = [PaymentModel]()
    let client = ApiClient()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getPaymentss()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getPaymentss() {
        arrayOfpayments.removeAll()
        SVProgressHUD.show()
        client.getPayments(successHandler: { (value) in
            
            let array = value
            for pay in array {
                self.arrayOfpayments.append(pay)
                
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            print(self.arrayOfpayments)
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }


}

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfpayments.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PaymentsTableViewCell
        
        cell.labelTitle.text = arrayOfpayments[indexPath.row].title
        if let urlImg = arrayOfpayments[indexPath.row].logo?.url{
            let urlStringFull = "\(serverUrl)\(urlImg)"
            if let urlImg = URL(string: urlStringFull){
                cell.imageLogo.af_setImage(withURL: urlImg)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PayDescriptionsViewController") as! PayDescriptionsViewController
        
        vc.img = arrayOfpayments[indexPath.row].logo?.url ?? "www.google.com"
        vc.descriptionPayment = arrayOfpayments[indexPath.row].description ?? "NoData"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
