//
//  ErrorResponse.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 15/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorResponse: Mappable {
    
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
