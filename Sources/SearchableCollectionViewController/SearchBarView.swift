import Foundation
import UIKit

open class SearchBarView: UICollectionReusableView {

    open static let height: CGFloat = 44.0
    open static let kind = String(describing: SearchBarView.self)
    open static let defaultSearchBackgroundColor = UIColor(hex: "00C365")

    open dynamic var searchBackgroundColor: UIColor? = SearchBarView.defaultSearchBackgroundColor {
        didSet {
            self.searchBar.backgroundColor = self.searchBackgroundColor
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.searchBar)
        self.searchBar.fillSuperview()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) open lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: SearchBarView.height))
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .default
        searchBar.backgroundColor = SearchBarView.defaultSearchBackgroundColor
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        return searchBar
    }()
}
