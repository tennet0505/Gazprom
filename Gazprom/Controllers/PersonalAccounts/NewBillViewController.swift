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
    
    let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
    let alertController = UIAlertController(title: nil, message: "Отправка данных...", preferredStyle: .alert)
    

    var label = ""
    var idAccount = 0
    var lastIndication = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acoountLabelonView.text = label
        lastIndication = UserDefaults.standard.double(forKey: "lastIndication")
        
    }
    @IBAction func payButtonOnView(_ sender: Any) {
        
        if addPayTextfield.text == ""{
            showAlert(title: "Введите показания счетчика!!!", message: "")
        }
        if let textToDouble = addPayTextfield.text?.doubleValue{
            let value = textToDouble
            if value > lastIndication{
                alertToPayment(lsString:  acoountLabelonView.text ?? "NoAccounts" , numbers: addPayTextfield.text ?? "NoNumbers" )}
            else{
                showAlert(title: "Внимание!", message: "Вводимые показания счетчика, должны быть больше предыдущего показания!")
                
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title , message: message  , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: {(_) in
            self.addPayTextfield.becomeFirstResponder()
        })
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
            self.loaderAlert()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.spinnerIndicator.stopAnimating()
                self.alertController.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: false)
            }
            self.dismiss(animated: true, completion: nil)
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
    func loaderAlert(){
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 100)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
    }
    
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0
    }
}
