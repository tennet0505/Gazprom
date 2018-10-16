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
