import Foundation
import UIKit

/// SearchableCollectionController is a subclass of SweetCollectionController
///
/// SearchableCollectionController replicates the behaviour and features of a UITableViewController with a UISearchController 
/// combined, with a UISearchBar as the headerView.
///
/// The UISearchBar can be customised directly, as it's accessible through the `searchBar` property.
/// The same applies to the UISearchController.
open class SearchableCollectionController: SweetCollectionController {

    /// The search bar from the backing UISearchController
    open var searchBar: UISearchBar {
        return self.searchController.searchBar
    }

    fileprivate var isAnimatingSearchBar: Bool = false

    /// The installed UISearchController. Override the delegate methods (call super) if necessary.
    open lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.dimsBackgroundDuringPresentation = false

        controller.searchBar.autoresizingMask = [.flexibleWidth]
        controller.delegate = self

        return controller
    }()

    private lazy var searchBarContainerView: UIView = {
        let view = UIView(withAutoLayout: true)
        view.backgroundColor = .clear

        return view
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = true

        self.view.addSubview(self.searchBarContainerView)
        self.searchBarContainerView.addSubview(self.searchBar)

        self.searchBarContainerView.attachToTop(viewController: self)
        self.searchBarContainerView.set(height: self.searchBar.frame.height)

        self.searchBar.sizeToFit()

        self.definesPresentationContext = true

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.collectionView.contentInset.top += self.searchBar.frame.height
    }
}

extension SearchableCollectionController: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
}

extension SearchableCollectionController: UICollectionViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.isAnimatingSearchBar == false else { return }

        let verticalOffset = scrollView.contentOffset.y + scrollView.contentInset.top

        self.searchBar.frame.origin.y = max(-self.searchBar.frame.height, -verticalOffset)
    }

    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let adjustedContentOffset = scrollView.contentOffset.y + scrollView.contentInset.top
        let searchBarHeight = self.searchBar.frame.height
        let halfHeight = searchBarHeight / 2.0

        let isOffsetInsideTopHalf = adjustedContentOffset <= halfHeight

        let isOffsetOutsideTopHalf = adjustedContentOffset > halfHeight
        let isOffsetInsideBar = adjustedContentOffset < searchBarHeight

        let isOffsetInsideBottomHalf = isOffsetInsideBar && isOffsetOutsideTopHalf

        if isOffsetInsideTopHalf {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
        } else if isOffsetInsideBottomHalf {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: self.searchBar.frame.height - scrollView.contentInset.top), animated: true)
        }
    }
}

extension SearchableCollectionController: UICollectionViewDelegateFlowLayout {

}

extension SearchableCollectionController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {
        self.isAnimatingSearchBar = true
    }

    public func didPresentSearchController(_ searchController: UISearchController) {
        self.isAnimatingSearchBar = false
    }

    public func willDismissSearchController(_ searchController: UISearchController) {
        self.isAnimatingSearchBar = true
    }

    public func didDismissSearchController(_ searchController: UISearchController) {
        self.isAnimatingSearchBar = false
    }
}
