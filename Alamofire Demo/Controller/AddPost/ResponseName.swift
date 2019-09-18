//
//  ResponseName.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 15/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseName: Mappable {
    
    var errorResponse: Status?
    var name : Name?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        errorResponse <- map["status"]
        name <- map["data"]
    }
}
