import UIKit

open class SearchBarContainerView: UIView {

    fileprivate var searchBar: UISearchBar

    open override var backgroundColor: UIColor? {
        get {
            return searchBar.barTintColor
        }
        set {
        }
    }

    public init(searchBar: UISearchBar) {
        self.searchBar = searchBar

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(self.searchBar)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
