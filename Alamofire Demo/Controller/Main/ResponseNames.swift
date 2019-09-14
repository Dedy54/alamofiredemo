//
//  ResponseNames.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 15/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseNames: Mappable {
    
    var errorResponse: ErrorResponse?
    var names = [Name]()
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        errorResponse <- map["status"]
        names <- map["data"]
    }
}

class Name: Mappable {
    
    var id: Int? = 0
    var name: String? = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
}
