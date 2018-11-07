//
//  SettingsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class SettingsViewController: UIViewController {
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var adressTextFields: UITextField!
    @IBOutlet weak var emailTextFields: UITextField!
    @IBOutlet weak var pushSwitch: UISwitch!
    
    var personal = [PersonalModel]()
    let client = ApiClient()
    var fullAddress = ""
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mail = UserDefaults.standard.string(forKey: "email"){
            email = mail
        }
        emailTextFields.text = email
      //  getPersonal()
    }
    func getPersonal() {
        SVProgressHUD.show()
        
        client.getPersonal(successHandler: { (value) in
            
            let array = value
            for personal in array {
                self.personal.append(personal)
                
            }
            if self.personal.count > 0{
                self.fullAddress = self.personal[0].city! + ", " + self.personal[0].address! + " " + self.personal[0].house_number! + "-" + self.personal[0].flat_number!
                self.adressTextFields.text = self.fullAddress
                if let account = self.personal[0].account{
                    self.nameTextField.text = "\(String(account))"
                }}
            SVProgressHUD.dismiss()
            print(self.personal)
            
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)    }
    
    @IBAction func LogOutButton(_ sender: Any) {
        print("LogOut Button Tap")
        UserDefaults.standard.set("", forKey: "auth_token")
        UserDefaults.standard.set("", forKey: "idUser")
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        present(vc, animated: true, completion: nil)

//        dismiss(animated: true, completion: nil)
    }
}
