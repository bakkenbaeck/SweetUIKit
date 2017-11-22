import Foundation
import UIKit
import SweetUIKit

class SearchCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel(withAutoLayout: true)
        view.textAlignment = .center

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(titleLabel)
        titleLabel.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class SearchableCollectionViewController: SearchableCollectionController {

    var isSearching: Bool {
        return searchTerm.count > 0
    }

    var searchTerm: String = ""

    var firstSection: [String] = [
        "0, 0",
        "0, 1",
        "0, 2",
        "0, 3",
        "0, 4",
        "0, 5",
        "0, 6",
        "0, 7",
        "0, 8",
    ]

    var secondSection: [String] = [
        "1, 0",
        "1, 1",
        "1, 2",
        "1, 3",
        "1, 4",
        "1, 5",
        "1, 6",
        "1, 7",
        "1, 8",
        "1, 9",
        "1, 10",
        "1, 11",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(SearchCell.self)
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .purple
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.isTranslucent = true
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isSearching {
                return firstSection.filter({ item -> Bool in
                    item.contains(self.searchTerm)
                }).count
            }

            return firstSection.count
        case 1:
            if isSearching {
                return secondSection.filter({ item -> Bool in
                    item.contains(self.searchTerm)
                }).count
            }

            return secondSection.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(SearchCell.self, for: indexPath)

        switch indexPath.section {
        case 0:
            cell.backgroundColor = .yellow

            if isSearching {
                cell.titleLabel.text = firstSection.filter({ item -> Bool in
                    item.contains(self.searchTerm)
                })[indexPath.row]
            } else {
                cell.titleLabel.text = firstSection[indexPath.row]
            }
        case 1:
            cell.backgroundColor = .purple

            if isSearching {
                cell.titleLabel.text = secondSection.filter({ item -> Bool in
                    item.contains(self.searchTerm)
                })[indexPath.row]
            } else {
                cell.titleLabel.text = secondSection[indexPath.row]
            }
        default:
            break
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2 - 25

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension SearchableCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
        collectionView.reloadData()
    }
}
