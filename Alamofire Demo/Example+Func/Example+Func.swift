//
//  Example+Func.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 15/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import ObjectMapper

class ExampleFunc {
    
    static func getRequest() {
        // https://httpbin.org/get?foo=bar
        let urlString = "https://httpbin.org/get"
        let parameters : [String : Any] = [
            "name": "bar"
        ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { response in
            print("\n\n[Response Handling]===== ===== ===== ===== =====\n\n")
            print("request: \(response.request)")    // original URL request
            print("response: \(response.response)")  // URL response
            print("data: \(response.data)")          // server data
            print("result: \(response.result)")       // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        Alamofire.request(urlString, method: .get).responseData { response in
            print("\n\n[Response Data Handler]===== ===== ===== ===== =====\n\n")
            print("request: \(response.request)")
            print("response: \(response.response)")
            print("result: \(response.result)")
        }
        
        Alamofire.request(urlString, method: .get).responseString { response in
            print("\n\n[Response String Handler]===== ===== ===== ===== =====\n\n")
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
        }
        
        Alamofire.request(urlString, method: .get).responseJSON { response in
            print("\n\n[Response JSON Handler]===== ===== ===== ===== =====\n\n")
            debugPrint(response)
        }
        
        Alamofire.request(urlString, method: .get).responseString { response in
            print("\n\n[Chained Response Handlers]===== ===== ===== ===== =====\n\n")
            print("Response String: \(response.result.value)")
            }.responseJSON { response in
                print("\n\n[Chained Response Handlers]===== ===== ===== ===== =====\n\n")
                print("Response JSON: \(response.result.value)")
        }
    }
    
    // MARK: POST
    func postRequest() {
        let urlString = "https://httpbin.org/post"
        let parameters = ["foo": "bar",
                          "baz": ["a", 1],
                          "quz": ["x": 1,
                                  "y": 2,
                                  "z": 3]] as [String : Any]
        // "Content-Type" = "application/x-www-form-urlencoded; charset=utf-8";
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { response in
            print("\n\n[default encoding]===== ===== ===== ===== =====\n\n")
            print("JSON: \(response.result.value)")
        }
    }
    
    // MARK: ContentType
    func contentTypeRequest() {
        let urlString = "https://httpbin.org/post"
        let parameters = ["foo": [1, 2, 3],
                          "bar": ["baz": "qux"]] as [String : Any]
        // "Content-Type" = "application/x-www-form-urlencoded; charset=utf-8";
        // "Content-Type" = "application/json";
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            print("\n\n[JSON encoding]===== ===== ===== ===== =====\n\n")
            print("JSON: \(response.result.value)")
        }
    }
    
    // MARK: Headers
    func headerRequest() {
        let urlString = "https:/httpbin.org/get"
        let headers = ["Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                       "Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(urlString, method: .get, headers: headers).responseJSON { response in
            print("\n\n[Headers]===== ===== ===== ===== =====\n\n")
            debugPrint(response)
        }
    }
    
    // MARK:- Upload File: File、Data、Stream、MultipartFormData
    func download() {
        let urlString = "https://httpbin.org/post"
        let fileURL: URL
        let parameters: Parameters = ["foo": "bar"]
        
        Alamofire.download(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, temporaryURL, destinationURL in
                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                print(response.temporaryURL)
                print(response.destinationURL)
        }
    }
    
    func authenticationWithNSURLCredential() {
        let user = "user"
        let password = "password"
        let urlString = "https://httpbin.org/basic-auth/\(user)/\(password)"
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        Alamofire.request(urlString, method: .get).authenticate(usingCredential: credential).responseJSON { response in
            debugPrint(response)
        }
    }
    
    // MARK:- Validation
    func validation() {
        let urlString = "https://httpbin.org/get"
        let parameters = ["foo": "bar"]
        Alamofire.request(urlString, method: .post, parameters: parameters).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).response { response in
            print(response)
        }
    }
    
    // MARK:- Timeline
    func timeline() {
        let urlString = "https://httpbin.org/get"
        let parameters = ["foo": "bar"]
        Alamofire.request(urlString, method: .post, parameters: parameters).validate().responseJSON { response in
            print(response.timeline)
        }
    }
    
}
