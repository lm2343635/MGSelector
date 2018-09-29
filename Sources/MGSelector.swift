
import UIKit
import SnapKit

fileprivate struct Const {
    static let margin = 16
    
    struct close {
        static let size = 20
    }
}

class MGSelectorViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_circle"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView?.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
     
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
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
    
    private var bottomPadding: CGFloat {
        var bottom: CGFloat = 0
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                bottom += window.safeAreaInsets.bottom
            }
        }
        return bottom
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}

extension MGSelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "cell \(indexPath.row)"
        cell.backgroundColor = .clear
        return cell
    }
    
}

extension MGSelectorViewController: UITableViewDelegate {
    
}

