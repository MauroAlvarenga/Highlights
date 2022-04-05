//
//  TopTwenty.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation

// MARK: Top Twenty Model
struct TopTwenty: Codable {
    let content: [Content]
    
    // In case of error:
    let message: String?
    let error: String?
    let status: Int?
}

// MARK: Content Model
struct Content: Codable {
    let id: String
    let position: Int
}
