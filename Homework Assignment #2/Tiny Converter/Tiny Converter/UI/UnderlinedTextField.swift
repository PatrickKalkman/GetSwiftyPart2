import UIKit

@IBDesignable class DesignableUITextField: UITextField {

    let border = CALayer()

    @IBInspectable var borderColor: UIColor? {
        didSet {
            setup()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            setup()
        }
    }

    func setup() {
        border.borderColor = self.borderColor?.cgColor

        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width,
            height: self.frame.size.height)
    }
}
