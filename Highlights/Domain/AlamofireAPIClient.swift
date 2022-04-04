//
//  AlamofireAPIClient.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 04/04/2022.
//

import Foundation
import Alamofire

class AlamofireAPIClient {
    
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url).response { response in
            completion(response.result)
        }
    }
    
    func post(url: String, parameters: Parameters, headers: HTTPHeaders, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            completion(response.result)
        }
    }
    
}
