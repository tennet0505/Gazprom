//
//  AuthViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/30/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let client = ApiClient()
    
    let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
    let alertController = UIAlertController(title: nil, message: "Отправка данных...", preferredStyle: .alert)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.layer.backgroundColor = #colorLiteral(red: 0.8177796602, green: 0.8177796602, blue: 0.8177796602, alpha: 1)
        passwordTextField.layer.backgroundColor = #colorLiteral(red: 0.8177796602, green: 0.8177796602, blue: 0.8177796602, alpha: 1)
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func getUser(){
        
        SVProgressHUD.show()
        let params: [String : String] = ["email": loginTextField.text ?? "no text",
                                         "password": passwordTextField.text ?? "no password"]
        client.postUserAuth(url: "auth_user",
                            params: params,
                            successHandler: { (response) in
            
            let user = response
            print(user.auth_token)
                                UserDefaults.standard.set(user.auth_token, forKey: "auth_token")
                                UserDefaults.standard.set(user.auth_token, forKey: "idUser")
                                UserDefaults.standard.set(user.user?.email, forKey: "email")

                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
                                
                                self.present(vc, animated: true, completion: nil)
                                SVProgressHUD.dismiss()
        }) { (error) in
            self.alert(title: "Warning", message: "NO User")
             SVProgressHUD.dismiss()
            print(error)
        }
        
    }
    
    @IBAction func OkButton(_ sender: Any) {
        
        if loginTextField.text == "" {
            alert(title: "Внимание!", message: "Введите логин!")
            loginTextField.layer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        if passwordTextField.text == "" {
            alert(title: "Внимание!", message: "Введите пароль!")
            loginTextField.layer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        if loginTextField.text != "" && passwordTextField.text != ""{
            // get request
            getUser()
            
           
        }
       
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            textField.layer.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }else{
            textField.layer.backgroundColor = #colorLiteral(red: 0.8177796602, green: 0.8177796602, blue: 0.8177796602, alpha: 1)
        }
    }
    
    @IBAction func registrationButton(_ sender: Any) {
        
       
        
    }
    

    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let action1 = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        alert.addAction(action1)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func loaderAlert(){
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 100)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
    }
}


