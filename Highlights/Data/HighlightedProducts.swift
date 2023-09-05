//
//  HighlightedProducts.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation

// MARK: Highlighted Products Model
struct HighligthedProducts: Codable {
    let body: Product?
    // In case of error:
    let message: String?
    let error: String?
    let status: Int?
}

// MARK: - BodyModel
struct Product: Codable {
    let id: String?
    let title: String?
    let permalink: String?
    let price: Double?
    let thumbnail: String?
    let subtitle: String?
    let pictures: [Picture]
}

struct Picture: Codable {
    let url: String?
}
