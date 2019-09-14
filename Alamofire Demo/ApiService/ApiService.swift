//
//  ApiService.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 15/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import ObjectMapper

class APIService {
    
    static let CONSTANT_API_URL = "https://5bloh8cd4j.execute-api.ap-southeast-1.amazonaws.com/dev/v1"
    
    static let READ = "\(CONSTANT_API_URL)/inbistro/read"
    static let CREATE = "\(CONSTANT_API_URL)/inbistro/create"
    static let UPDATE = "\(CONSTANT_API_URL)/inbistro/update"
    static let DELETE = "\(CONSTANT_API_URL)/inbistro/delete"
    
    static func getNames(onSuccess: @escaping ([Name])->(), onError: @escaping (ErrorResponse?)->())  {
        Alamofire.request(self.READ, method: .post).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                var names = [Name]()
                if let responseNames = Mapper<ResponseNames>().map(JSONObject: value){
                    if (responseNames.errorResponse?.code == 200){
                        names = responseNames.names
                    } else {
                        onError(responseNames.errorResponse)
                    }
                }
                onSuccess(names)
                break
            case .failure(let error):
                var e : ErrorResponse? = nil
                e?.message = error.localizedDescription
                onError(e)
                break
            }
        }
    }
    
    static func createNames(onSuccess: @escaping ([Name])->(), onError: @escaping (ErrorResponse?)->())  {
        
    }
    
    static func updateNames(onSuccess: @escaping ([Name])->(), onError: @escaping (ErrorResponse?)->())  {
        
    }
    
    static func deleteNames(onSuccess: @escaping ([Name])->(), onError: @escaping (ErrorResponse?)->())  {
        
    }
    
}
