import UIKit

extension UIView {
    @discardableResult
    func layout<E: UIView>(subView: E, closure: ((E) -> Void)? = nil) -> E {
        self.addSubview(subView)
        closure?(subView)
        return subView
    }
}

extension UIStackView {
    @discardableResult
    func arrangedLayout<E: UIView>(subView: E, closure: ((E) -> Void)? = nil) -> E {
        self.addArrangedSubview(subView)
        closure?(subView)
        return subView
    }
}
