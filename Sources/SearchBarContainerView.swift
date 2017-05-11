import UIKit

open class SearchBarContainerView: UIView {

    fileprivate var searchBar: UISearchBar

    open override var backgroundColor: UIColor? {
        get {
            return self.searchBar.barTintColor
        }
        set {
            
        }
    }

    public init(searchBar: UISearchBar) {
        self.searchBar = searchBar

        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.searchBar)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
