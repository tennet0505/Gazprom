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

//struct MarkerModel {
//    var longitude: String?
//    var latitude: String?
//    var title: String?
//
//    init(latitude: String, longitude: String, title: String) {
//        self.latitude = latitude
//        self.longitude = longitude
//        self.title = title
//    }
//}

