//
//  PaymentsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController {

    var arrayOfpayment = ["Visa","Wallet","Cash"]
    var arrayOfpayLogo = ["Visa","Wallet","Cash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PaymentsTableViewCell
        cell.labelTitle.text = arrayOfpayment[indexPath.row]
        cell.imageLogo.image = UIImage(named: arrayOfpayLogo[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PayDescriptionsViewController") as! PayDescriptionsViewController
        
        vc.img = arrayOfpayLogo[indexPath.row]
        vc.descriptionPayment = arrayOfpayment[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
