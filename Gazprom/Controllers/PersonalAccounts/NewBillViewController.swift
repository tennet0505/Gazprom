//
//  NewBillViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/17/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class NewBillViewController: UIViewController {

    @IBOutlet weak var viewPayment: UIView!
    @IBOutlet weak var acoountLabelonView: UILabel!
    @IBOutlet weak var addPayTextfield: UITextField!
    
    var label = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        acoountLabelonView.text = label
        
    }
    @IBAction func payButtonOnView(_ sender: Any) {
        
       navigationController?.popViewController(animated: true)
        
    }
}
