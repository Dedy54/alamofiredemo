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
    
    var status: Status?
    var datas = [Name]()
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        datas <- map["data"]
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

class Status: Mappable {
    
    var success: Bool? = false
    var code: Int? = 0
    var message: String? = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        success <- map["success"]
    }
    
}
