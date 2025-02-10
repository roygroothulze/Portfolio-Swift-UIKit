//
//  Book.swift
//  Portfolio Swift UIKit
//
//  Created by CodeBlock on 07/02/2025.
//

import Foundation

struct Book: Codable {
    let title: String
    let firstPublishYear: Int
    let authorName: [String]?
    let coverID: Int?
    let editionCount: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case firstPublishYear = "first_publish_year"
        case authorName = "author_name"
        case coverID = "cover_i"
        case editionCount = "edition_count"
    }
}

struct OpenLibraryResponse: Codable {
    let docs: [Book]
}
