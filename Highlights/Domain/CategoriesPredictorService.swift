//
//  CategoriesPredictorService.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation
import Alamofire

protocol CategoriesServiceProtocol {
    // Used to get only one category
    func getTopCategory(search keyword: String, completion: @escaping (PredictorCategories) -> Void)
    // Used to get multiple categories
    func getMultipleCategories(search keyword: String, amount: Int, completion: @escaping (PredictorCategories) -> Void)
}

class CategoriesPredictionService: CategoriesServiceProtocol {
    
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
    public func getTopCategory(search keyword: String, completion: @escaping (PredictorCategories) -> Void) {
        let url = "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?limit=1&q=\(keyword)"
        apiClient.get(url: url, headers: authHeaders) { response in
            switch response {
            case .success(let data):
                do {
                    if let jsonData = data {
                        let receivedData = try JSONDecoder().decode(PredictorCategories.self, from: jsonData)
                        completion(receivedData)
                    }
                } catch {
                    print("Error decoding Top Category")
                    print(error)
                    completion([PredictorCategory(domain_id: "Error decoding", domain_name: "", category_id: "Error decoding", category_name: "Error decoding")])
                }
            case .failure(let error):
                print("Error getting Top Category")
                print(error)
                completion([PredictorCategory(domain_id: "Error fetching", domain_name: "", category_id: "Error fetching", category_name: "Error fetching")])
            }
        }
    }
    
    public func getMultipleCategories(search keyword: String, amount: Int, completion: @escaping (PredictorCategories) -> Void) {
        // TODO: Get more categories to show a list of possible searches.
        let url = "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?limit=\(amount)&q=\(keyword)"
        apiClient.get(url: url, headers: authHeaders) { response in
            switch response {
            case .success(let data):
                do {
                    if let jsonData = data {
                        let receivedData = try JSONDecoder().decode(PredictorCategories.self, from: jsonData)
                        completion(receivedData)
                    }
                } catch {
                    print("Error decoding Top Category")
                    print(error)
                    completion([PredictorCategory(domain_id: "Error decoding", domain_name: "", category_id: "Error decoding", category_name: "Error decoding")])
                }
            case .failure(let error):
                print("Error getting Top Category")
                print(error)
                completion([PredictorCategory(domain_id: "Error fetching", domain_name: "", category_id: "Error fetching", category_name: "Error fetching")])
            }
        }
    }
    
}
