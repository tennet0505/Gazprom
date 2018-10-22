//
//  Request.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/16/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ApiClient {
    
    let serverUrl = "https://puppit.spalmalo.com"
    
    var jsonHeaders:HTTPHeaders{
        return ["Content-Type":"application/json"]
    }
    func newError(_ name:String) -> Error {
        let errorDomain = "com.spalmalo.Promzona-space"
        let userInfo = [NSLocalizedFailureReasonErrorKey: "error in \(name)"]
        let returnError = NSError(domain: errorDomain, code: 1, userInfo: userInfo)
        return returnError
    }
    
    
    func getOffices ( successHandler :@escaping ([MarkerModel])->(),
                      errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/offices.json"
        
        Alamofire.request(URL,
                          headers: jsonHeaders)
            .responseArray { (response: DataResponse<[MarkerModel]>) in
                
                if let itemArray = response.result.value{
                    successHandler(itemArray)
                }
        }
    }
    func getNews ( successHandler :@escaping ([NewsModel])->(),
                   errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/news.json"
        
        Alamofire.request(URL,
                          headers: jsonHeaders)
            .responseArray { (response: DataResponse<[NewsModel]>) in
                
                if let itemArray = response.result.value{
                    successHandler(itemArray)
                }
        }
    }
    
    func getPayments ( successHandler :@escaping ([PaymentModel])->(),
                       errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/payments.json"
        
        Alamofire.request(URL,
                          headers: jsonHeaders)
            .responseArray { (response: DataResponse<[PaymentModel]>) in
                
                if let itemArray = response.result.value{
                    successHandler(itemArray)
                }
        }
    }
    
    func getFAQ ( successHandler :@escaping ([FAQModel])->(),
                  errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/faqs.json"
        
        Alamofire.request(URL,
                          headers: jsonHeaders)
            .responseArray { (response: DataResponse<[FAQModel]>) in
                
                if let itemArray = response.result.value{
                    successHandler(itemArray)
                }
        }
    }
    
    func getPersonal( successHandler :@escaping ([PersonalModel])->(),
                  errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/personal_accounts.json"
        
        Alamofire.request(URL,
                          headers: jsonHeaders)
            .responseArray { (response: DataResponse<[PersonalModel]>) in
                
                if let itemArray = response.result.value{
                    successHandler(itemArray)
                }
        }
    }
    
    func getCountries ( url: String,
                        successHandler :@escaping (Dictionary<String, [String]>)->(),
                        errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/\(url)"
        Alamofire.request(URL, headers: jsonHeaders).responseJSON { (response) in
            //  print(response.result.value)
            
            if let itemArray = response.result.value{
                successHandler(itemArray as! Dictionary<String, [String]> )
            }
        }
    }
    
    func postRequest (  url: String,
                        params: [String: String],
                        successHandler :@escaping (Dictionary<String, [String]>)->(),
                        errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/\(url)"
        Alamofire.request(URL,
                          parameters: params,
                          headers: jsonHeaders).responseJSON  { (response) in
            print(response.result.value ?? " ")
            
            if let itemArray = response.result.value{
                successHandler(itemArray as! Dictionary<String, [String]> )
            }
        }
    }
    func postRequestStreets (  url: String,
                               params: [String: String],
                               successHandler :@escaping (Dictionary<String, [String]>)->(),
                               errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/\(url)"
        Alamofire.request(URL,
                          parameters: params, headers: jsonHeaders).responseJSON  { (response) in
            print(response.result.value ?? " ")
            
            if let itemArray = response.result.value{
                successHandler(itemArray as! Dictionary<String, [String]> )
            }
        }
    }
    
    func postNewAccount (url: String,
                         params: [String: [String:String]],
                         successHandler :@escaping (Dictionary<String, [String]>)->(),
                         errorHandler   :@escaping (Error)->()){
        
        let URL = "\(serverUrl)/\(url)"
        Alamofire.request(
            URL,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers:jsonHeaders
            ).responseJSON  { (response) in
                print(response.result.value ?? "")
            
            if let itemArray = response.result.value{
                successHandler(itemArray as!  Dictionary<String, [String]>)
            }
        }
    }
    func deletePersonal( id: Int,
                         successHandler :@escaping ()->(),
                         errorHandler   :@escaping (Error)->()){
        
        Alamofire.request("\(serverUrl)/personal_accounts/\(id)",
            method: .delete,
            encoding: JSONEncoding.default,
            headers: jsonHeaders)
            .response { (response) in
                successHandler()
        }
    }
}
