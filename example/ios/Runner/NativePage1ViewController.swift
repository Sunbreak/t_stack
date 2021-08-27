import SnapKit
import t_stack

class NativePage1ViewController: UIViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    lazy var statusBarHeight = UIApplication.shared.windows.first!.windowScene!.statusBarManager!.statusBarFrame.height

    func initView() {
        view.backgroundColor = UIColor.white

        let stack = view.layout(subView: UIStackView()) { s in
            s.axis = .vertical
            s.alignment = .center
            s.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(self.statusBarHeight)
                make.width.equalToSuperview()
            }
        }

        stack.arrangedLayout(subView: UIButton(type: .system, primaryAction: UIAction { _ in
            self.present(TFlutterViewController(routeName: "flutterPage1"), animated: true)
        })) { b in
            b.setTitle("push(FlutterPage1)", for: .normal)
        }

        stack.arrangedLayout(subView: UIButton(type: .system, primaryAction: UIAction { _ in
            self.present(TFlutterViewController(routeName: "flutterPage2"), animated: true)
        })) { b in
            b.setTitle("push(FlutterPage2)", for: .normal)
        }
    }
}
