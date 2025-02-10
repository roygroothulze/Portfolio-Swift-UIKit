//
//  BookListViewController.swift
//  Portfolio Swift UIKit
//
//  Created by CodeBlock on 07/02/2025.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    private var viewModel = BookViewModel()
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let emptyStateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupEmptyStateLabel()
        updateEmptyState()
        
        view.backgroundColor = .white
    }

    private func setupNavigationBar() {
        title = "Book Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for books"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupEmptyStateLabel() {
        emptyStateLabel.text = "No books found. Start searching above."
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .gray
        emptyStateLabel.numberOfLines = 0
        view.addSubview(emptyStateLabel)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func updateEmptyState() {
        emptyStateLabel.isHidden = !viewModel.books.isEmpty
        tableView.isHidden = viewModel.books.isEmpty
    }

    private func fetchBooks(query: String) {
        Task {
            await viewModel.fetchBooks(query: query)
            await MainActor.run {
                tableView.reloadData()
                updateEmptyState()
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = viewModel.books[indexPath.row]
        cell.textLabel?.text = "\(book.title) (\(book.firstPublishYear))"
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedBook = viewModel.books[indexPath.row]
        let bookDetailViewController = BookDetailViewController(book: selectedBook)
        navigationController?.pushViewController(bookDetailViewController, animated: true)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        fetchBooks(query: searchText)
    }
}
