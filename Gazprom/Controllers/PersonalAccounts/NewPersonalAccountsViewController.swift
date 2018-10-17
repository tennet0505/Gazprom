//
//  PersonalAccountsDescriptionViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class NewPersonalAccountsViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lsTextField: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var buildLabel: UITextField!
    @IBOutlet weak var flatLabel: UITextField!
    
    var arrayOfAccounts = [personalAccountsModel]()
    var personal = personalAccountsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func buttonSave(_ sender: Any) {
    
        personal.ls = lsTextField.text
        personal.city = cityLabel.text
        personal.address = addressLabel.text
        personal.numberBuild = Int(buildLabel.text ?? "0")
        personal.numberFlat = Int(flatLabel.text ?? "0")
      
        arrayOfAccounts.append(personal)
       
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PersonalAccountsViewController") as! PersonalAccountsViewController
        vc.arrayOfAccounts = arrayOfAccounts
        
        navigationController?.popViewController(animated: true)
     //   performSegue(withIdentifier: "segueToPersonalAccounts", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "segueToPersonalAccounts",
            let vc = segue.destination as? PersonalAccountsViewController{
            vc.arrayOfAccounts = arrayOfAccounts
          
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
