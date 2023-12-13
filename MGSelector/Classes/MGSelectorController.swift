//
//  MGSelectorViewController.swift
//  MGSelector
//
//  Created by Meng Li on 2018/09/21.
//  Copyright © 2018 MuShare. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import SnapKit

fileprivate struct Const {
    static let selectorCell = "selectorCell"
    static let margin = 20
    
    struct title {
        static let margin = 25
    }
    
    struct close {
        static let margin = 25
        static let size = 30
    }
}

class MGSelectorViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = theme.mainColor
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = theme.mainColor
        button.addTarget(nil, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MGSelectTableViewCell.self, forCellReuseIdentifier: Const.selectorCell)
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
        view.backgroundColor = theme.backgroundColor
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var tapView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
    
    private let theme: MGSelectorTheme
    private var items: [MGSelectorItem]
    private let mode: MGSelectorMode
    
    weak var delegate: MGSelectable?
    
    init(
        title: String?,
        options: [MGSelectorOption],
        mode: MGSelectorMode,
        theme: MGSelectorTheme
    ) {
        self.theme = theme
        self.mode = mode
        switch mode {
        case .single(let selectedIndex):
            self.items = options.enumerated().map {
                MGSelectorItem(option: $0.element, selected: $0.offset == selectedIndex)
            }
        case .multiple(let selectedIndexes):
            self.items = options.enumerated().map {
                MGSelectorItem(option: $0.element, selected: selectedIndexes.contains($0.offset))
            }
        }
        
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = theme.maskColor
        titleLabel.text = title
    }
    
    deinit {
        view.removeGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tapView)
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(tableView)
        createConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCorner()
    }
    
    private func createConstraints() {
        
        tableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Const.margin)
            $0.right.equalToSuperview().offset(-Const.margin)
            $0.bottom.equalToSuperview().offset(-bottomPadding)
            $0.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(tableView.snp.top).offset(-Const.title.margin)
            $0.left.equalToSuperview().offset(Const.margin)
            $0.right.equalToSuperview().offset(-Const.title.margin)
        }
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(Const.close.size)
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-Const.margin)
        }
        
        backgroundView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.top).offset(-Const.margin)
        }
        
        tapView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(backgroundView.snp.top)
        }
        
    }
    
    private func setCorner() {
        let path = UIBezierPath(
            roundedRect: backgroundView.bounds,
            byRoundingCorners: [.topRight, .topLeft],
            cornerRadii: CGSize(width: 10, height:  10)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = backgroundView.bounds
        maskLayer.path = path.cgPath
        backgroundView.layer.mask = maskLayer
    }
    
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    private var bottomPadding: CGFloat {
        var bottom: CGFloat = 0
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .last { $0.isKeyWindow }
        bottom += keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom
    }
    
    
}

extension MGSelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.selectorCell, for: indexPath) as? MGSelectTableViewCell else {
            return UITableViewCell()
        }
        cell.theme = theme
        cell.item = items[indexPath.row]
        return cell
    }
    
}

extension MGSelectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch mode {
        case .single:
            items = items.enumerated().map {
                MGSelectorItem(option: $0.element.option, selected: $0.offset == indexPath.row)
            }
        case .multiple:
            items = items.enumerated().map {
                MGSelectorItem(
                    option: $0.element.option,
                    selected: $0.offset == indexPath.row ? !$0.element.selected : $0.element.selected
                )
            }
        }
        delegate?.didSelect(options: items.filter { $0.selected }.map { $0.option })
        tableView.reloadData()
    }
    
}
