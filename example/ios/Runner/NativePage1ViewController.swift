class NativePage1ViewController: UIViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    var statusBarHeight: CGFloat {
        get {
            if #available(iOS 13.0, *), let m = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
                return m.statusBarFrame.height
            } else {
                return UIApplication.shared.statusBarFrame.height
            }
        }
    }

    func initView() {
        view.backgroundColor = UIColor.white

        let stack = UIStackView()
        view.addSubview(stack)
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: stack.superview!.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: stack.superview!.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: stack.superview!.topAnchor, constant: statusBarHeight).isActive = true

        let label = UILabel()
        stack.addArrangedSubview(label)
        label.text = "NativePage1"
    }
}
