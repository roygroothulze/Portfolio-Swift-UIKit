//
//  BookDetailViewController.swift
//  Portfolio Swift UIKit
//
//  Created by CodeBlock on 10/02/2025.
//

import UIKit

class BookDetailViewController: UIViewController {
    private let book: Book

    private let coverImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let yearLabel = UILabel()
    private let editionCountLabel = UILabel()
    private let descriptionLabel = UILabel()

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        updateViews()
        fetchCoverImage()
    }

    private func setupViews() {
        coverImageView.contentMode = .scaleAspectFit
        view.addSubview(coverImageView)

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        authorLabel.font = .systemFont(ofSize: 18)
        authorLabel.textAlignment = .center
        authorLabel.textColor = .gray
        view.addSubview(authorLabel)

        yearLabel.font = .systemFont(ofSize: 18)
        yearLabel.textAlignment = .center
        yearLabel.textColor = .gray
        view.addSubview(yearLabel)

        editionCountLabel.font = .systemFont(ofSize: 18)
        editionCountLabel.textAlignment = .center
        editionCountLabel.textColor = .gray
        view.addSubview(editionCountLabel)

        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        editionCountLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 150),
            coverImageView.heightAnchor.constraint(equalToConstant: 225),

            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            yearLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            editionCountLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10),
            editionCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editionCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: editionCountLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func updateViews() {
        titleLabel.text = book.title
        authorLabel.text = "Author: \(book.authorName?.joined(separator: ", ") ?? "Unknown")"
        yearLabel.text = "First Publish Year: \(book.firstPublishYear)"
        editionCountLabel.text = "Edition Count: \(book.editionCount ?? 0)"
    }

    private func fetchCoverImage() {
        guard let coverID = book.coverID else { return }
        let coverURLString = "https://covers.openlibrary.org/b/id/\(coverID)-L.jpg"
        guard let coverURL = URL(string: coverURLString) else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: coverURL)
                await MainActor.run {
                    coverImageView.image = UIImage(data: data)
                }
            } catch {
                print("Failed to fetch cover image: \(error)")
            }
        }
    }
}
