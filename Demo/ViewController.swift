import UIKit

class ViewController: SweetCollectionViewController {

    lazy var data: [String] = {
        return ["123", "321", "lol"]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .magentaColor()

        self.collectionView.register(CollectionCell.self)
        self.collectionView.backgroundColor = .lightGrayColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCell.reuseIdentifier, forIndexPath: indexPath) as! CollectionCell
        cell.backgroundColor = .whiteColor()
        cell.label.text = self.data[indexPath.row]
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}

extension ViewController: UICollectionViewDelegate {

}