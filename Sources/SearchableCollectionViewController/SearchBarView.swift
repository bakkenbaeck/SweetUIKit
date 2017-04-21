import Foundation
import UIKit

class SearchBarView: UICollectionReusableView {
    
    static let height: CGFloat = 44.0
    static let kind = String(describing:SearchBarView.self)
    static let defaultSearchBackgroundColor = UIColor(hex: "00C365")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
        searchBar.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var searchBar: UISearchBar = {
        let bar = UISearchBar.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width,
                                                 height: SearchBarView.height))
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.barStyle = .default
        bar.backgroundColor = SearchBarView.defaultSearchBackgroundColor
        bar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        return bar
    }()
}
