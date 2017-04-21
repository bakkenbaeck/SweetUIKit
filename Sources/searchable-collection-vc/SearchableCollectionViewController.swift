//
//  SearchableCollectionViewController.swift
//  Demo
//
//  Created by Yuliia Veresklia on 20/04/2017.
//
//

import Foundation
import UIKit

class SearchableCollectionController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = SearchableCollectionViewLayout()
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        (view as UIScrollView).delegate = self
        view.backgroundColor = UIColor.white
        view.contentInset = UIEdgeInsetsMake(0.0, 0.0, SearchBarView.height, 0.0)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        view.addSubview(collectionView)
        collectionView.pinToSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = SearchBarView.defaultSearchBackgroundColor
    }
}

extension SearchableCollectionController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y >= 22 && scrollView.contentOffset.y < SearchBarView.height {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: SearchBarView.height), animated: true)
        } else if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 22.0 {
            scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        }
    }
}
