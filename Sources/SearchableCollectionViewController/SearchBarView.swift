import Foundation
import UIKit

class SearchBarView: UICollectionReusableView {

    static let height: CGFloat = 44.0
    static let kind = String(describing: SearchBarView.self)
    static let defaultSearchBackgroundColor = UIColor(hex: "00C365")

    dynamic var searchBackgroundColor: UIColor? = SearchBarView.defaultSearchBackgroundColor {
        didSet {
            SearchBarView.searchBar.backgroundColor = self.searchBackgroundColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(SearchBarView.searchBar)
        SearchBarView.searchBar.fillSuperview()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: SearchBarView.height))
        searchBar.tag = SearchBarTag
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .default
        searchBar.backgroundColor = SearchBarView.defaultSearchBackgroundColor
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        return searchBar
    }()
}
