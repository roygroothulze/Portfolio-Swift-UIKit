//
//  BookServiceProtocol.swift
//  Portfolio Swift UIKit
//
//  Created by CodeBlock on 07/02/2025.
//

import Foundation

protocol BookServiceProtocol {
    func fetchBooks(query: String) async throws -> [Book]
}

class BookService: BookServiceProtocol {
    func fetchBooks(query: String) async throws -> [Book] {
        let urlString = "https://openlibrary.org/search.json?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(OpenLibraryResponse.self, from: data)
        return response.docs
    }
}
