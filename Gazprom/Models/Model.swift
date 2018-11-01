//
//  MarkerModel.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/16/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import Foundation
import ObjectMapper

class MarkerModel: Mappable {
    
    var
    latitude: Double?,
    longitude: Double?,
    title: String?
    
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lon"]
        title <- map["title"]        
    }
    
}
class NewsModel: Mappable {
    
    var
    title: String?,
    description: String?,
    created_at: String?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        created_at <- map["created_at"]
    }
}
class PaymentModel: Mappable {
    
    var
    title: String?,
    description: String?,
    logo: LogUrl?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        logo <- map["logo"]
    }
}
class LogUrl: Mappable {
    
    var
    url: String?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
       
        url <- map["url"]
    }
}
class FAQModel: Mappable {
    
    var
    question: String?,
    answer: String?,
    created_at: String?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        question <- map["question"]
        answer <- map["answer"]
        created_at <- map["created_at"]
    }
}

class PersonalModel: Mappable {
    
    var
    id: Int?,
    account: Int?,
    city: String?,
    address: String?,
    house_number: String?,
    flat_number: String?
  //  meter_reading: [IndicationModel]?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        account <- map["account"]
        city <- map["city"]
        house_number <- map["house_number"]
        address <- map["address"]
        flat_number <- map["flat_number"]
  //      meter_reading <- map["meter_reading"]
    }
    
}
class IndicationModel: Mappable {
    
    var
    id: Int?,
    created_at: String?,
    indication: Double?,
    personal_account_id: Int?,
    updated_at: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        indication <- map["indication"]
        personal_account_id <- map["personal_account_id"]
        updated_at <- map["updated_at"]
    }
    init(id: Int?, created_at: String?, indication: Double?) {
        self.id = id
        self.created_at = created_at
        self.indication = indication
    }
}




class IndicationsPersonalAccountModel: Mappable{
    var
    personal_account:PersonalModel?,
    meter_reading:[IndicationModel]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        personal_account <- map["personal_account"]
        meter_reading <- map["meter_reading"]
    }
    
}
class AuthModel: Mappable {
    
    var
    auth_token: String?,
    user: UserModel?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        auth_token <- map["auth_token"]
        user <- map["user"]
    }
}
class UserModel: Mappable {
    
    var
    id: Int?,
    email: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
    }
}

