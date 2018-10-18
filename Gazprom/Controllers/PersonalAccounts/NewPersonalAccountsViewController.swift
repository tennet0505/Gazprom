//
//  PersonalAccountsDescriptionViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewPersonalAccountsViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lsTextField: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var countryLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var buildLabel: UITextField!
    @IBOutlet weak var flatLabel: UITextField!
    
    let client = ApiClient()
    
    var arrayOfAccounts = [personalAccountsModel]()
    var personal = personalAccountsModel()
    var arrayOfCountries = ["Выберите страну:"]
    var arrayOfCities = ["Выберите город:"]
    var arrayOfSreets = ["Выберите улицу:"]
    
    let pickerCountry = UIPickerView()
    let pickerCity = UIPickerView()
    let pickerStreet = UIPickerView()
    var countrySelected = ""
    var citySelected = ""
    var streetSelected = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickers()
        getCountries(url: "countries")
        
    }
    
    func pickers() {
        countryLabel.inputView = pickerCountry
        cityLabel.inputView = pickerCity
        addressLabel.inputView = pickerStreet
        pickerCountry.delegate = self
        pickerCity.delegate = self
        pickerStreet.delegate = self
        pickerCountry.tag = 0
        pickerCity.tag = 1
        pickerStreet.tag = 2
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
extension NewPersonalAccountsViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(cancelButton(_:)))
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButton(_:)))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([cancelButton, flex, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        countryLabel.inputAccessoryView = toolbar
        cityLabel.inputAccessoryView = toolbar
    }
    
    
    @objc func cancelButton(_ sender: UIBarButtonItem)
    {
        self.view.endEditing(true)
        
    }
    @objc func doneButton(_ sender: UIBarButtonItem)
    {
        
//        countrySelected = teamSelected
//        idProffi = ProffiSelected
//        self.view.endEditing(true)
//        print("done button pressed")
//        print("id of Team: \(teamSelected)")
//        print("id of Proffi: \(ProffiSelected)")
        
        // Send Data team on server for add data team
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            
            return arrayOfCountries.count
            
        } else if pickerView.tag == 1 {
            
            return arrayOfCities.count
            
        } else if pickerView.tag == 2 {
            
            return arrayOfSreets.count
        }
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            
            return self.arrayOfCountries[row]
            
        } else if pickerView.tag == 1 {
            
            return self.arrayOfCities[row]
            
        } else if pickerView.tag == 2 {
            
            return self.arrayOfSreets[row]
        }
        
        return nil
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            if row != 0{
                countryLabel.text = arrayOfCountries[row]
                countrySelected = countryLabel.text ?? "No Country selected"
                postRequest(url: "cities", countrySelected: self.countrySelected)
            }
            
        } else if pickerView.tag == 1 {
            if row != 0{
                cityLabel.text = arrayOfCities[row]
                citySelected = cityLabel.text ?? "No City selected"
                postRequestStreets(url: "addresses", citySelected: self.citySelected)
            }
            
        } else if pickerView.tag == 2 {
            if row != 0{
                addressLabel.text = arrayOfSreets[row]
            }
        }
    }
}

extension NewPersonalAccountsViewController{
    
    func getCountries(url: String) {
        SVProgressHUD.show()
        arrayOfCountries.removeAll()
        arrayOfCountries = ["Выберите страну:"]
        client.getCountries(url: url,
                            successHandler: { (dictionary) in
            
            if let dict = dictionary["countries"]{
                for country in dict {
                    self.arrayOfCountries.append(country)
                    
                    print(self.arrayOfCountries)

                    SVProgressHUD.dismiss()
                }
            }
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    func postRequest(url: String, countrySelected: String) {
      
        arrayOfCities.removeAll()
        arrayOfCities = ["Выберите город:"]
        client.postRequest(url: url, params: ["country" : countrySelected], successHandler: { (dictionary) in
            
            if let dict = dictionary["cities"]{
                for country in dict {
                    self.arrayOfCities.append(country)
                    self.postRequestStreets(url: "addresses", citySelected: "Бишкек")
                    print(self.arrayOfCities)
                    SVProgressHUD.dismiss()
                }
            }
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    func postRequestStreets(url: String, citySelected: String) {
        
        arrayOfSreets.removeAll()
        arrayOfSreets = ["Выберите улицу:"]
        client.postRequest(url: url, params: ["city" : citySelected], successHandler: { (dictionary) in
            
            if let dict = dictionary["addresses"]{
                for country in dict {
                    self.arrayOfSreets.append(country)
                    
                    print(self.arrayOfSreets)
                    SVProgressHUD.dismiss()
                }
            }
        }) { (error) in
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    
}
