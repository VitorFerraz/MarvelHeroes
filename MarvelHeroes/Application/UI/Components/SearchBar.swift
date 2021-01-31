import UIKit

class SearchBar: UISearchBar {

    var customFont: UIFont = StyleGuide.SearchBar.font
    var customTextColor: UIColor = StyleGuide.SearchBar.textColor
    
    init(frame: CGRect, customFont: UIFont = StyleGuide.SearchBar.font, customTextColor: UIColor = StyleGuide.SearchBar.textColor) {
        super.init(frame: frame)
        self.frame = frame
        self.searchBarStyle = .prominent
        self.isTranslucent = true
        self.customFont = customFont
        self.customTextColor = customTextColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        if let searchBarIndex = getIndexFromSearchBarInSubView() {
            if let searchField: UITextField = (subviews[0] as UIView).subviews[searchBarIndex] as? UITextField {
                let textFieldFrame: CGRect = CGRect(x: 8.0, y: 4.0, width: frame.width - 16, height: frame.height - 8.0)
                searchField.frame = textFieldFrame
                searchField.font = customFont
                searchField.textColor = customTextColor
                searchField.backgroundColor = barTintColor
                searchField.tintColor = .white
            }
        }
        super.draw(rect)
    }
    
    private func getIndexFromSearchBarInSubView() -> Int? {
        var index: Int?
        let searchBarView: UIView = subviews[0] as UIView
        for (idx, subView) in searchBarView.subviews.enumerated() {
            if subView is UITextField {
                index = idx
                break
            }
        }
        return index
    }
}
