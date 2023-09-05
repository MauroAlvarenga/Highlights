//
//  PredictorCategories.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 04/04/2022.
//

import Foundation

// MARK: Predictor Category Model
struct PredictorCategory: Codable {
    let domain_id: String
    let domain_name: String
    let category_id: String
    let category_name: String
    //let attributes: [Attributes?]?
}

typealias PredictorCategories = [PredictorCategory]
