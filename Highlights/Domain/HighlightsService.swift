//
//  HighlightsService.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation
import Alamofire

protocol HighlightsServiceProtocol {
    // Used to get top 20 items from a category.
    func getHighlights(from category_id: String, completion: @escaping (Highlights) -> Void)
}
    

class HighlightsService: HighlightsServiceProtocol {
    
    // MARK: Properties
    let apiClient = AlamofireAPIClient()
    
    lazy var accessToken: String = {
        let defaults = UserDefaults.standard
        guard let token = defaults.object(forKey: "accessToken") as? String else { return "" }
        return token
    }()
    
    lazy var authHeaders: HTTPHeaders = {
        return [
            "Authorization": "Bearer \(self.accessToken)"
        ]
    }()
    
    // MARK: Methods
    public func getHighlights(from category: String, completion: @escaping (Highlights) -> Void) {
        let url = "https://api.mercadolibre.com/highlights/MLA/category/\(category)"
        apiClient.get(url: url, headers: authHeaders) { response in
            switch response {
            case .success(let data):
                do {
                    if let jsonData = data {
                        let receivedData = try JSONDecoder().decode(Highlights.self, from: jsonData)
                        completion(receivedData)
                    }
                } catch {
                    print("Error decoding test Categories")
                    print(error)
                }
            case .failure(let error):
                print("Error getting test Categories")
                print(error)
            }
        }
    }
    
}
