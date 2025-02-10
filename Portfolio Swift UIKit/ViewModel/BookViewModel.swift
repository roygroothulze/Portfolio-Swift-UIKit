//
//  BookViewModel.swift
//  Portfolio Swift UIKit
//
//  Created by CodeBlock on 07/02/2025.
//

import Foundation

@MainActor
class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let bookService: BookServiceProtocol

    init(bookService: BookServiceProtocol = BookService()) {
        self.bookService = bookService
    }

    func fetchBooks(query: String) async {
        do {
            books = try await bookService.fetchBooks(query: query)
        } catch {
            // Handle error
            print("Failed to fetch books: \(error)")
        }
    }
}
