import UIKit

class ViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        cell.tag = indexPath.row

        return cell
    }
}
