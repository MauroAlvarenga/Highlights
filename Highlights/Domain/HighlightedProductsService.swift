//
//  HighlightedProductsService.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation
import Alamofire

class HighlightedProductsService {

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
    public func getProducts(withIDs listID: [String], completion: @escaping ([Product]) -> Void) {
        var IDs: String = ""
        listID.forEach { IDs.append("\($0),") }
        let url = "https://api.mercadolibre.com/items?ids=\(IDs)&attributes=id,price,title,subtitle,permalink,thumbnail,pictures"
        apiClient.get(url: url, headers: authHeaders) { response in
            switch response {
            case .success(let data):
                do {
                    if let jsonData = data {
                        let receivedData = try JSONDecoder().decode([HighligthedProducts].self, from: jsonData)
//                        var products2: [Product] = []
//                        receivedData.forEach { receivedProduct in
//                            if let product = receivedProduct.body {
//                                products2.append(product)
//                            }
//                        }
                        let products = receivedData.map { receivedProduct -> Product in
                            guard let product = receivedProduct.body else { return Product(id: "error", title: "error", permalink: nil, price: 0, thumbnail: nil, subtitle: nil, pictures: [Picture(url: "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")]) }
                            return product
                        }
                        completion(products)
                    }
                } catch {
                    print("Error decoding highligthed products")
                    print(error)
                }
            case .failure(let error):
                print("Error getting highligthed products")
                print(error)
            }
        }
    }
}
