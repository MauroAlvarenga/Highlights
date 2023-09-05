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
    private var categories: PredictorCategories?
    private let highlightsService: HighlightsService
    private var highlights: Highlights?
    private let productsService: HighlightedProductsService
    private var highligthedProducts: [Product]?
    
    // MARK: Inits
    init(categoriesService: CategoriesPredictionService, highlightsService: HighlightsService, productsService: HighlightedProductsService) {
        self.categoriesService = categoriesService
        self.highlightsService = highlightsService
        self.productsService = productsService
    }
    
    func getTopCategory(search keyword: String, completion: @escaping () -> Void ){
        categoriesService.getTopCategory(search: keyword) { [weak self] receivedCategory in
            guard let strongSelf = self else { return }
            strongSelf.categories = receivedCategory
            completion()
        }
    }
    
    func getCategories() -> PredictorCategories {
        if let categories = categories {
            return categories
        }
        return PredictorCategories()
    }
    
    func getHighlights(from category_id: String, completion: @escaping () -> Void) {
        highlightsService.getHighlights(from: category_id) { [weak self] receivedHighlights in
            guard let strongSelf = self else { return }
            strongSelf.highlights = receivedHighlights
            completion()
        }
    }
    
    func getHighlightsCount() -> Int {
        if let highlights = highlights?.content {
            return highlights.count
        }
        return 1
    }
    
    func getHighlightsListID() -> [String] {
        if let highlightsList = highlights?.content {
            var listID: [String] = []
            highlightsList.forEach { item in
                listID.append(item.id)
            }
            return listID
        }
        return [String]()
    }
    
    func getHighlightID(position: Int) -> String {
        if let highlights = highlights?.content {
            return highlights[position].id
        }
        return "Error getting ID"
    }
    
    func getProducts(withIDs listID: [String], completion: @escaping () -> Void) {
        productsService.getProducts(withIDs: listID) { [weak self] receivedProducts in
            guard let strongSelf = self else { return }
            strongSelf.highligthedProducts = receivedProducts
            completion()
        }
    }
    
    func getProductsList() -> [Product] {
        if let highligthedProducts = highligthedProducts {
            return highligthedProducts
        }
        return [Product(id: "error", title: "error", permalink: nil, price: 0, thumbnail: "error", subtitle: "Error", pictures: [Picture(url: "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")])]
    }
    
    func getProduct(withID id: String) -> Product {
        if let highligthedProducts = highligthedProducts {
            if let foundProduct = highligthedProducts.first(where: { $0.id == id }) {
                return foundProduct
            }
        }
        return Product(id: "error", title: "error", permalink: nil, price: 0, thumbnail: "error", subtitle: "error", pictures: [Picture(url: "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")])
    }
    
}
