import UIKit


struct StyleGuide {
    struct SearchBar {
        static let font: UIFont = .systemFont(ofSize: 16.0)
        static let textColor: UIColor = .white
        static let tintColor: UIColor = .clear
    }
    
    struct CollectionView {
        static let backgroundColor: UIColor         = .clear
        static let itemSize: CGSize                 = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.5)
        static let minimumLineSpacing: CGFloat      = 50.0
        static let minimumInteritemSpacing: CGFloat = 50.0
        static let sectionInset: UIEdgeInsets       = .init(top: 100, left: 80, bottom: 100, right: 80)
        static let itemIdentifier                   = String(describing: CardCollectionCell.self)
    }
    
    struct Colors {
        static var grayTheme: UIColor {
            return UIColor(hexString: "#3B383D")
        }
    }
    
    struct CardLabel {
        static let font: UIFont = .systemFont(ofSize: 17)
        static let textColor: UIColor = .white
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


