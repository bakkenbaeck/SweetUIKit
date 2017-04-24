import Foundation
import UIKit

open class SearchableCollectionController: UIViewController {

    open lazy var collectionView: UICollectionView = {
        let layout = SearchableCollectionViewLayout()

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: SearchBarView.height, right: 0)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false

        return view
    }()

    open var searchBackgroundColor: UIColor? = SearchBarView.defaultSearchBackgroundColor {
        didSet {
            self.updateSearchColor()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(self.collectionView)
        self.collectionView.fillSuperview()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.updateSearchColor()
    }

    private func updateSearchColor() {
        SearchBarView.appearance().searchBackgroundColor = self.searchBackgroundColor
    }
}

extension SearchableCollectionController: UICollectionViewDelegate {
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
        let adjustedContentOffset = scrollView.contentOffset.y + scrollView.contentInset.top

        if adjustedContentOffset <= SearchBarView.height / 2 {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
        } else if adjustedContentOffset > SearchBarView.height / 2 && adjustedContentOffset < SearchBarView.height {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: SearchBarView.height - scrollView.contentInset.top), animated: true)
        }
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
