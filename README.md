# SweetUIKit

[![Version](https://img.shields.io/cocoapods/v/SweetUIKit.svg?style=flat)](https://cocoapods.org/pods/SweetUIKit)
[![License](https://img.shields.io/cocoapods/l/SweetUIKit.svg?style=flat)](https://cocoapods.org/pods/SweetUIKit)
[![Platform](https://img.shields.io/cocoapods/p/SweetUIKit.svg?style=flat)](https://cocoapods.org/pods/SweetUIKit)

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

### Shake

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

## UIViewController

#### Application window

```swift
let window = self.applicationWindow()
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
