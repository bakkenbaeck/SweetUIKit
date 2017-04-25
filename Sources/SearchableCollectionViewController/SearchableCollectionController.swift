import Foundation
import UIKit

let SearchBarTag = 123

open class SearchableCollectionController: SweetCollectionController {

    open var searchBar: UISearchBar {
        return self.searchController.searchBar
    }

    open lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.dimsBackgroundDuringPresentation = false

        controller.searchBar.autoresizingMask = [.flexibleWidth]

        return controller
    }()

    lazy var searchBarContainerView: UIView = {
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

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

extension SearchableCollectionController: UICollectionViewDelegate, UIScrollViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.searchController.isActive == false else { return }

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
