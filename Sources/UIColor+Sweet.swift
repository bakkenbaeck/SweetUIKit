import UIKit

public extension UIColor {
    /// Base initializer, it creates an instance of `UIColor` using an HEX string.
    ///
    /// - Parameter hex: The base HEX string to create the color.
    public convenience init(hex: String) {
        let noHashString = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: noHashString)
        scanner.charactersToBeSkipped = CharacterSet.symbols
        
        var hexInt: UInt32 = 0
        if (scanner.scanHexInt32(&hexInt)) {
            let red = (hexInt >> 16) & 0xFF
            let green = (hexInt >> 8) & 0xFF
            let blue = (hexInt) & 0xFF

            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        } else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }

    /// Compares if two colors are equal.
    ///
    /// - Parameter color: A UIColor to compare.
    /// - Returns: A boolean, true if same (or very similar) and false otherwise.
    public func isEqual(to color: UIColor) -> Bool {
        let RGBA = self.RGBA
        let other = color.RGBA
        let margin = CGFloat(0.01)

        func comp(a: CGFloat, b: CGFloat) -> Bool {
            return abs(b-a) <= (a*margin)
        }

        return comp(a: RGBA[0], b: other[0]) && comp(a: RGBA[1], b: other[1]) && comp(a: RGBA[2], b: other[2]) && comp(a: RGBA[3], b: other[3])
    }


    /// Get the red, green, blue and alpha values.
    private var RGBA: [CGFloat] {
        var RGBA: [CGFloat] = [0,0,0,0]
        self.getRed(&RGBA[0], green: &RGBA[1], blue: &RGBA[2], alpha: &RGBA[3])

        return RGBA
    }
}
