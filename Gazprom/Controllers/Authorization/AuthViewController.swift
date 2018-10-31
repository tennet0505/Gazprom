//
//  AuthViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/30/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func OkButton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
        
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func registrationButton(_ sender: Any) {
        
       
        
    }
}
