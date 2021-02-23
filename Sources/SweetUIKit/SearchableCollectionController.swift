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
        return searchController.searchBar
    }

    fileprivate var isAnimatingSearchBar = false

    fileprivate var isActive = false

    /// The installed UISearchController. Override the delegate methods (call super) if necessary.
    open lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)

        controller.dimsBackgroundDuringPresentation = false
        controller.delegate = self

        if #available(iOS 11.0, *) {
            controller.hidesNavigationBarDuringPresentation = false
        } else {
            controller.hidesNavigationBarDuringPresentation = true
            controller.searchBar.autoresizingMask = [.flexibleWidth]
        }

        return controller
    }()

    private lazy var searchBarContainerView: SearchBarContainerView = {
        return SearchBarContainerView(searchBar: self.searchBar)
    }()

    open var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        return UINavigationItem.LargeTitleDisplayMode.always
    }

    open var hidesSearchBarWhenScrolling: Bool {
        return false
    }

    open var prefersLargeTitles: Bool {
        return true
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        title = "Searchable"

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
            self.navigationItem.searchController = searchController
            self.navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
            self.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        } else {
            view.addSubview(searchBarContainerView)
            searchBarContainerView.attachToTop(viewController: self)
            searchBarContainerView.set(height: searchBar.frame.height)
            definesPresentationContext = true
        }
        searchBar.sizeToFit()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.top += searchBar.frame.height
    }
}

extension SearchableCollectionController: UICollectionViewDataSource {
    open func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    open func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 0
    }
}

extension SearchableCollectionController: UICollectionViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isAnimatingSearchBar && !isActive else { return }

        guard #available(iOS 11.0, *) else {
            let verticalOffset = scrollView.contentOffset.y + scrollView.contentInset.top
            searchBar.frame.origin.y = max(-searchBar.frame.height, -verticalOffset)

            return
        }
    }

    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
        let adjustedContentOffset = scrollView.contentOffset.y + scrollView.contentInset.top
        let searchBarHeight = searchBar.frame.height
        let halfHeight = searchBarHeight / 2.0

        let isOffsetInsideTopHalf = adjustedContentOffset <= halfHeight

        let isOffsetOutsideTopHalf = adjustedContentOffset > halfHeight
        let isOffsetInsideBar = adjustedContentOffset < searchBarHeight

        let isOffsetInsideBottomHalf = isOffsetInsideBar && isOffsetOutsideTopHalf

        if isOffsetInsideTopHalf {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
        } else if isOffsetInsideBottomHalf {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: searchBar.frame.height - scrollView.contentInset.top), animated: true)
        }
    }
}

extension SearchableCollectionController: UICollectionViewDelegateFlowLayout {
}

extension SearchableCollectionController: UISearchControllerDelegate {
    /// Call super to keep the same animation behaviours
    ///
    open func willPresentSearchController(_: UISearchController) {
        guard #available(iOS 11.0, *) else {
            isAnimatingSearchBar = true
            return
        }
    }

    /// Call super to keep the same animation behaviours
    ///
    open func didPresentSearchController(_: UISearchController) {
        guard #available(iOS 11.0, *) else {
            isAnimatingSearchBar = false
            isActive = true
            return
        }
    }

    /// Call super to keep the same animation behaviours
    ///
    open func willDismissSearchController(_: UISearchController) {
        guard #available(iOS 11.0, *) else {
            isAnimatingSearchBar = true
            return
        }
    }

    /// Call super to keep the same animation behaviours
    ///
    open func didDismissSearchController(_: UISearchController) {
        guard #available(iOS 11.0, *) else {
            isAnimatingSearchBar = false
            isActive = false
            scrollViewDidEndDragging(collectionView, willDecelerate: false)

            return
        }
    }
}
