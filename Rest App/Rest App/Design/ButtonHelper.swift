import UIKit

struct ButtonHelper {
    static func configureButton(button: UIButton, backgroundColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.tintColor = .white
        button.layer.cornerRadius = button.bounds.height / 2
        button.clipsToBounds = true
    }
}
