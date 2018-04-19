import UIKit

class SingleTypeDataSourceDemoViewController: UIViewController {

    private lazy var tableView = UITableView(withAutoLayout: true)

    private lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                 target: self,
                                                 action: #selector(addWord))

    private lazy var insertButton = UIBarButtonItem(barButtonSystemItem: .compose,
                                                    target: self,
                                                    action: #selector(insertWord))

    private var dataSource: StringDataSource!

    private let words = [
        "Everything",
        "in",
        "its",
        "right",
        "place",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])

        dataSource = StringDataSource(tableView: tableView,
                                      selectionAction: { [weak self] string in
                                          print("Selected \(string)")
                                          self?.dataSource.remove(item: string)
        })

        navigationItem.rightBarButtonItems = [addButton, insertButton]
    }

    @objc private func addWord() {
        let randomIndex = Int(arc4random_uniform(UInt32(words.count)))
        dataSource.append(item: words[randomIndex])
    }

    @objc private func insertWord() {
        let randomWordIndex = Int(arc4random_uniform(UInt32(words.count)))
        let word = words[randomWordIndex]
        let randomDataSourceIndex = Int(arc4random_uniform(UInt32(dataSource.itemCount)))
        dataSource.insert(item: word, at: randomDataSourceIndex)
    }
}
