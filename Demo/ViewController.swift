import UIKit

class ViewController: SweetCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .magentaColor()

        self.collectionView.register(UICollectionViewCell.self)

        self.data = ["123", "321", "lol"]
    }
}

extension ViewController: UICollectionViewDelegate {
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(UICollectionViewCell.reuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = .redColor()

        return cell
    }
}
