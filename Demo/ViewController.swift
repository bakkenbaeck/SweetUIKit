import UIKit

class ViewController: SweetCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .magentaColor()

        self.collectionView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.collectionView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        self.collectionView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor).active = true
        self.collectionView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
        self.collectionView.register(UICollectionViewCell.self)

        self.data = ["123", "321", "lol"]
    }
}

extension ViewController {
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(UICollectionViewCell.reuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = .redColor()
        return cell
    }
}
