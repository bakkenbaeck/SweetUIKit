import UIKit

extension UIScrollView {
    var isAtTop: Bool {
        return self.contentOffset.y <= self.topVerticalContentOffset
    }

    var isAtBottom: Bool {
        return self.contentOffset.y >= self.bottomVerticalContentOffset
    }

    var topVerticalContentOffset: CGFloat {
        let topInset = self.contentInset.top

        return -topInset
    }

    var bottomVerticalContentOffset: CGFloat {
        let scrollViewHeight = self.bounds.height
        let scrollContentSizeHeight = self.contentSize.height
        let bottomInset = self.contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight

        return scrollViewBottomOffset
    }
    
}
