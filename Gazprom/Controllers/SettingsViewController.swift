//
//  SettingsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var adressTextFields: UITextField!
    @IBOutlet weak var emailTextFields: UITextField!
    @IBOutlet weak var pushSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)    }
    
}
