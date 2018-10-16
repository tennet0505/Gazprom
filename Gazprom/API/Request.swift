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
}
