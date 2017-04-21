import Foundation
import UIKit

public class SearchableCollectionController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = SearchableCollectionViewLayout()
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.backgroundColor = UIColor.white
        view.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: SearchBarView.height, right: 0.0)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    var searchBackgroundColor: UIColor? = SearchBarView.defaultSearchBackgroundColor {
        didSet { updateSearchColor() }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateSearchColor()
    }
    
    private func updateSearchColor() {
        SearchBarView.appearance().searchBackgroundColor = searchBackgroundColor
    }
}

extension SearchableCollectionController: UICollectionViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y >= SearchBarView.height / 2 && scrollView.contentOffset.y < SearchBarView.height {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: SearchBarView.height), animated: true)
        } else if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < SearchBarView.height / 2 {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        }
    }
}