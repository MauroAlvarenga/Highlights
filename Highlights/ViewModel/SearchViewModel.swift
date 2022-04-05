//
//  SearchViewModel.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation

class SearchViewModel {
    
    // MARK: Properties
    private let categoriesService: CategoriesPredictionService
    private var categories: PredictorCategory?
    
    // MARK: Inits
    init(service: CategoriesPredictionService) {
        self.categoriesService = service
    }
    
    func getTopCategory(search keyword: String, completion: @escaping (PredictorCategory) -> Void ){
        categoriesService.getTopCategory(search: keyword) { receivedCategory in
            completion(receivedCategory[0])
        }
    }
    
    func getCategories() {
        
    }
    
    
}
