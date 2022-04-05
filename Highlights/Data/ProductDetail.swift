//
//  ProductDetail.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation

// MARK: Product Detail Model
struct ProductDetail: Codable {
    let body: Body
    // In case of error:
    let message: String?
    let error: String?
    let status: Int?
}

// MARK: - BodyModel
struct Body: Codable {
    let title: String?
    let subtitle: String?
    let price: Int?
}
