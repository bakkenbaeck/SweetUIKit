//
//  CaseIterableViewController.swift
//  iOSDemo
//
//  Created by Ellen Shapiro (Work) on 9/21/18.
//

import UIKit
import SweetUIKit

enum Section: String, CaseIterable {
    case user
    case app
    case logout

    var title: String {
        return rawValue.uppercased()
    }
}

enum UserRow: CaseIterable {
    case username
    case emailAddress

    var title: String {
        switch self {
        case .username:
            return "User name"
        case .emailAddress:
            return "Email address"
        }
    }

    var value: String {
        switch self {
        case .username:
            return "foobar"
        case .emailAddress:
            return "foo@bar.baz"
        }
    }
}

enum AppRow: CaseIterable {
    case currentVersion
    case contactDeveloper
    case leaveReview

    var title: String {
        switch self {
        case .currentVersion:
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "(Version unknown)"
        case .contactDeveloper:
            return "Contact the developer"
        case .leaveReview:
            return "Leave a review"
        }
    }

    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .currentVersion:
            return .none
        case .contactDeveloper,
             .leaveReview:
            return .disclosureIndicator
        }
    }
}

enum LogoutRow: String, CaseIterable {
    case reset
    case logout

    var title: String {
        return rawValue.capitalized
    }

    var textColor: UIColor {
        switch self {
        case .reset:
            return .darkText
        case .logout:
            return .red
        }
    }
}

class CaseIterableViewController: UIViewController {

    private lazy var cellIdentitfier = String(describing: self)

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentitfier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CaseIterable Example"

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
}

extension CaseIterableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.forIndex(section) {
        case .user:
            return UserRow.allCases.count
        case .app:
            return AppRow.allCases.count
        case .logout:
            return LogoutRow.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentitfier, for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.textColor = .darkText

        switch Section.forSection(at: indexPath) {
        case .user:
            let row = UserRow.forRow(at: indexPath)
            cell.textLabel?.text = row.title
            cell.detailTextLabel?.text = row.value
        case .app:
            let row = AppRow.forRow(at: indexPath)
            cell.textLabel?.text = row.title
            cell.accessoryType = row.accessoryType
        case .logout:
            let row = LogoutRow.forRow(at: indexPath)
            cell.textLabel?.text = row.title
            cell.textLabel?.textColor = row.textColor
        }

        return cell
    }
}

extension CaseIterableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch Section.forSection(at: indexPath) {
        case .user:
            switch UserRow.forRow(at: indexPath) {
            case .username:
                showAlert(with: "Show username edit")
            case .emailAddress:
                showAlert(with: "Show email address edit")
            }
        case .app:
            switch AppRow.forRow(at: indexPath) {
            case .currentVersion:
                showAlert(with: "Tapped Current Version")
            case .contactDeveloper:
                showAlert(with: "Start an email to the developer")
            case .leaveReview:
                showAlert(with: "Send user to app store to leave a review")
            }
        case .logout:
            switch LogoutRow.forRow(at: indexPath) {
            case .reset:
                showAlert(with: "Reset user settings but don't log them out")
            case .logout:
                showAlert(with: "Log out the user!")
            }
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.forIndex(section).title
    }

    private func showAlert(with title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)

        alert.addAction(okAction)

        present(alert, animated: true)
    }
}
