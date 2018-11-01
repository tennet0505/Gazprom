//
//  RegistrationViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/30/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    let client = ApiClient()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        newPassword.text = ""
        confirmNewPassword.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func createNewUser() {
        
        SVProgressHUD.show()
        let params: [String: String] = ["email": loginTextField.text!,
                                        "password": newPassword.text!,
                                        "password_confirmation": confirmNewPassword.text!]
        client.createNewUserAuth(url: "users.json", params: params, successHandler: { (value) in
            print(value)
            let user = value
            UserDefaults.standard.set(user.auth_token, forKey: "auth_token")
            UserDefaults.standard.set(user.auth_token, forKey: "idUser")
            UserDefaults.standard.set(user.user?.email, forKey: "email")
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
            
            self.present(vc, animated: true, completion: nil)
            SVProgressHUD.dismiss()
        }) { (error) in
            
            self.alert(title: "Внимание!", message: "Пользователь уже зарегестрирован.")
            SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    
    @IBAction func registrationButton(_ sender: Any) {
        print("registration tap button")
        
        if newPassword.text != "" && confirmNewPassword.text != "" && loginTextField.text != ""{
            if (newPassword.text?.count)! >= 6{
                if newPassword.text == confirmNewPassword.text{
                    
                    createNewUser()
                   
                }else{

                    alert1(title:  "Внимание!", message: "Пароли не совпадают!")
                }
            }else{
                
                alert(title: "Внимание!", message: "Длина пароля должна быть больше 6-ти символов!")
            }
            
        }else{
            alert1(title: "Внимание!", message: "Заполните все поля!")
            
        }
    }
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func alert1(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
