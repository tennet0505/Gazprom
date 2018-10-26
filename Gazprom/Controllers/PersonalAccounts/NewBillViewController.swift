//
//  NewBillViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/17/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire


class NewBillViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewPayment: UIView!
    @IBOutlet weak var acoountLabelonView: UILabel!
    @IBOutlet weak var addPayTextfield: UITextField!
    let client = ApiClient()

    var label = ""
    var idAccount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        acoountLabelonView.text = label
        
    }
    @IBAction func payButtonOnView(_ sender: Any) {
        
        if addPayTextfield.text == ""{
            showAlert()
        }else{
            
            alertToPayment(lsString:  acoountLabelonView.text ?? "NoAccounts" , numbers: addPayTextfield.text ?? "NoNumbers" )
        }
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Введите показания счетчика!!!", message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertToPayment(lsString: String, numbers: String){
        let alert = UIAlertController(title: "Лицевой счет: \(lsString)", message: "Показания счетчика: \(numbers)" , preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (alert) in
            
            if let text = self.addPayTextfield.text{
                if let textToInt = Int(text){
                    self.getIndication(id: self.idAccount, params: ["indication" : textToInt])
                }
            }
            self.navigationController?.popViewController(animated: false)
        }
        let action2 = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alert.addAction(action2)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func getIndication(id: Int, params: [String: Int]) {
        
        client.postIndications(url: "personal_accounts/\(id)/set_indication", params: params, successHandler: { (response) in
        
            print("success:", response)
            
        }) { (error) in
            print(error)
        }
    }
    
}
//https://puppit.spalmalo.com/personal_accounts/1/set_indication?indication=22211
