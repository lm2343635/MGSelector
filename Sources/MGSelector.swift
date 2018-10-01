
import UIKit
import SnapKit

fileprivate struct Const {
    static let selectorCell = "selectorCell"
    static let margin = 16
    
    struct close {
        static let size = 30
    }
}

class MGSelectorViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(fill(image: UIImage(named: "close"), with: .darkGray), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MGSelectTableViewCell.self, forCellReuseIdentifier: Const.selectorCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView?.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let options: [MGSelectorOption]
    
    weak var delegate: MGSelectable?
    
    init(title: String, options: [MGSelectorOption]) {
        self.options = options
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(tableView)
        createConstraints()
    }
    
    private func createConstraints() {
        tableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Const.margin)
            $0.right.equalToSuperview().offset(-Const.margin)
            $0.bottom.equalToSuperview().offset(-bottomPadding)
            $0.height.equalTo(tableView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(tableView.snp.top).offset(-Const.margin)
            $0.left.equalToSuperview().offset(Const.margin)
            $0.right.equalTo(closeButton.snp.left).offset(-Const.margin)
        }

        closeButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-Const.margin)
            $0.size.equalTo(Const.close.size)
            $0.centerY.equalTo(titleLabel)
        }
        
        backgroundView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.top).offset(-Const.margin)
        }
        
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    private var bottomPadding: CGFloat {
        var bottom: CGFloat = 0
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                bottom += window.safeAreaInsets.bottom
            }
        }
        return bottom
    }
    
    private func fill(image: UIImage?, with color: UIColor) -> UIImage? {
        guard let image = image else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        color.setFill()
        
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        context.draw(image.cgImage!, in: rect)
        
        context.setBlendMode(CGBlendMode.sourceIn)
        context.addRect(rect)
        context.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return coloredImg
    }
}

extension MGSelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.selectorCell, for: indexPath) as? MGSelectTableViewCell else {
            return UITableViewCell()
        }
        cell.option = options[indexPath.row]
        return cell
    }
    
}

extension MGSelectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(option: options[indexPath.row])
        dismiss(animated: true)
    }
    
}

