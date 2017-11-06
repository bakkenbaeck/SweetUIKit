# SweetUIKit

[![Version](https://img.shields.io/cocoapods/v/SweetUIKit.svg?style=flat)](https://cocoapods.org/pods/SweetUIKit)
[![License](https://img.shields.io/cocoapods/l/SweetUIKit.svg?style=flat)](https://cocoapods.org/pods/SweetUIKit)
[![Platform](https://img.shields.io/cocoapods/p/SweetUIKit.svg?style=flat)](https://cocoapods.org/pods/SweetUIKit)

## SearchableCollectionView

We provide a `SearchableCollectionController`, a subclass of `SweetCollectionController` that provides the same search functionality that a `UITableView` combined with a `UISearchController` can provide. That includes attaching the search bar to the bottom of the navigation bar, handling scrolling animations and automatically handling its positioning so that it’s never half-shown. Exactly the same as the native table view behaviour.

### Implementing

Just subclass it, override the following methods and it should be good to go.

```swift
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
```

Of course it won’t do much until you also implement the `UISearchBar` delegate method. 

Here’s a very naive implementation:

```swift
extension SearchableCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
        self.collectionView.reloadData()
    }
}
```

## Dequeuing Cells

### UITableView

```swift
// Before
let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell

// After
let cell = tableView.dequeue(TitleCell.self, for: indexPath)
```

### UICollectionView

```swift
// Before
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

// After
let cell = collectionView.dequeue(CollectionViewCell.self, for: indexPath)
```

## Registering Cells

Simple protocol extensions to simplify registering a cell in UITableViewController and UICollectionViewController.

**Before**: 
```swift
self.tableView.registerClass(ItemCell.self, forCellReuseIdentifier: "ItemCell")
```

**After**: 
```swift
self.tableView.register(ItemCell.self)
```

Also, accessing the cell identifier is as easy as using `ItemCell.reuseIdentifier`.


## UIAlertController

### Dismissable alert

```swift
let alertController = UIAlertController.dismissableAlert(title: "Not allowed access", message: "Please contact your admin to get access.")
self.presentViewController(alertController, animated: true, completion: nil)
```

### Destructive confirmation alert

```swift
let alertController = UIAlertController.destructiveConfirmationAlert(message: "Are you sure you want to log out?", destructiveActionTitle: "Log out") {
    self.controllerDelegate?.settingsControllerDidPressLogoutButton(self)
}
self.presentViewController(alertController, animated: true, completion: nil)
```

### Error alert

```swift
let alertController = UIAlertController.errorAlert(error)
self.presentViewController(alertController, animated: true, completion: nil)
```

### Progress alert

```swift
let progressAlert = UIAlertController.progressAlert("Creating album...")
self.presentViewController(progressAlert, animated: true, completion: nil)
self.fetcher.createAlbum(title: self.titleTextField.text, photos: self.selectedPhotos) { error in
    progressAlert.dismissViewControllerAnimated(true) {
        if let error = error {
            let alertController = UIAlertController.errorAlert(error)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Success
        }
    }
}
```

## UILabel

### Calculate width

```swift
let width = self.usernameLabel.width()
// Do something with new width
```

## UIView

### Nib support

Helper class method to create a view from a nib file directly. Supports overriding the bundle and the name of the nib. Takes 4 possible arguments. Nib name, bundle, file owner and options. Same as when using `UINib(nibName:bundle).instantiate(withOwner:options:)`.


```swift
let myView = MyView.instanceFromNib(nibName: "ViewXibName", bundle:  .main)
```

### Autolayout
#### Fill superview

Set a view’s top, left, right and bottom anchors to be the same as the superviews. Accepts an optional `UIEdgeInsets` argument. Values can be all positive for margins, as it handles the negative values for bottom and right constants already.

```swift
    view.fillSuperview()
    
    anotherView.fillSuperview(UIEdgeInsets(top: 10, left: 10, bottom: 80, right: 10))
```

#### Set hight and width anchors directly

```swift
    view.set(height: 30.0)
    view.set(width: 50.0)
```

#### Attach to top
Great for toolbars, attaches to view to the top of the superview. Doesn’t set a height. If you pass a view controller, it will attach to `viewController.topLayoutGuide.bottomAnchor` instead of `superview.topAnchor`. 

```swift
    toolbar.attachToTop(viewController: self)
```

#### Shake

```swift
self.fetcher.authenticate(username, password: password) { clientID, clientSecret, accessToken, refreshToken, expiresIn, error in
    if let error = error {
        // Update UI to display error
        self.tableView.shake()
    } else {
      // success
    }
}
```

## UIImage

#### Resizing

You can resize an image by providing a new height, width or scale rate.

```swift
let image = UIImage()
let scaledImage = image.resized(by: 0.5) // CGInterpolationQuality defaults to .medium
let widthImage = image.resized(toWidth: 300) // scales up or down as needed
let heightImage = image.resized(toHeight: 300)
```

#### Centered frame

```swift
let image = UIImage(named: "art.png")!
let frame = image.centeredFrame()
// Do something with new frame
```

#### Image with colour

```swift
let image = UIImage(color: .red)
button.setBackgroundImage(image, for: .normal)
```

or, if you need the image to have specific dimensions

```swift
let image = UIImage(color: .red, size: someSize)
```

#### Colours from RGBA values

Create images using `rgba(255,255,255,1.0)` values.

```swift
    UIColor(r: 200, b: 120, c: 255)
    UIColor(r: 200, b: 120, c: 25, 0.5)
```


## UIViewController

#### Application window

```swift
let window = self.applicationWindow()
```

## Keyboard Aware Accessory View

This keyboard aware accessory view is part of your view(controller) and moves with the keyboard.

#### KeyboardAwareAccessoryViewDelegate

```swift
var keyboardAwareInputView: KeyboardAwareInputAccessoryView { get }
```

```swift
inputView(_:shouldUpdatePosition:)
```


## Installation

**SweetUIKit** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SweetUIKit'
```

**SweetUIKit** is also available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "UseSweet/SweetUIKit" ~> 1.0
```

## License

**SweetUIKit** is available under the MIT license. See the LICENSE file for more info.

## Author

Bakken & Bæck, [@use_sweet](https://twitter.com/use_sweet)
