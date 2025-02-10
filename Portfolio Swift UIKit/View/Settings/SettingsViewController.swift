//
//  SettingsViewController.swift
//  Portfolio Swift UIKit
//
//  Created by CodeBlock on 10/02/2025.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let developerInfo = DeveloperInfo(
        name: "Roy Groot Hulze",
        email: "info@roygroothulze.nl",
        github: "https://github.com/roygroothulze",
        linkedIn: "https://linkedin.com/in/roygroothulze"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = developerInfo.name
            cell.accessoryType = .none
        case 1:
            cell.textLabel?.text = "Email"
            cell.detailTextLabel?.text = developerInfo.email
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = "GitHub"
            cell.detailTextLabel?.text = developerInfo.github
            cell.accessoryType = .disclosureIndicator
        case 3:
            cell.textLabel?.text = "LinkedIn"
            cell.detailTextLabel?.text = developerInfo.linkedIn
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var urlString: String?

        switch indexPath.row {
        case 1:
            urlString = "mailto:\(developerInfo.email)"
        case 2:
            urlString = developerInfo.github
        case 3:
            urlString = developerInfo.linkedIn
        default:
            break
        }

        if let urlString = urlString, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
