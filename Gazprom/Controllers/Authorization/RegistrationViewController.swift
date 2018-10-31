//
//  RegistrationViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/30/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        newPassword.text = ""
        confirmNewPassword.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func registrationButton(_ sender: Any) {
        print("registration tap button")
        
        if newPassword.text != "" && confirmNewPassword.text != "" && loginTextField.text != ""{
            
            if newPassword.text == confirmNewPassword.text{
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
                
                present(vc, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Внимание!", message: "Пароли не совпадают!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                let action1 = UIAlertAction(title: "Отмена", style: .default, handler: nil)
                alert.addAction(action1)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            
        }else{
            let alert = UIAlertController(title: "Внимание!", message: "Заполните все поля!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            let action1 = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alert.addAction(action1)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
