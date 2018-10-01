//
//  MGSelectTableViewCell.swift
//  MGSelector_Example
//
//  Created by Meng Li on 2018/10/01.
//  Copyright © 2018 MuShare. All rights reserved.
//

import UIKit

class MGSelectTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = .darkGray
        textView.backgroundColor = .clear
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(titleLabel)
        addSubview(detailTextView)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
    var theme: MGSelectorTheme = .light {
        didSet {
            titleLabel.textColor = theme.mainColor
            detailTextView.textColor = theme.secondaryColor
        }
    }
    
    var option: MGSelectorOption? {
        didSet {
            guard let option = option else {
                return
            }
            titleLabel.text = option.title
            
            if let detail = option.detail {
                detailTextView.text = detail
                detailTextView.snp.makeConstraints {
                    $0.left.equalToSuperview()
                    $0.right.equalToSuperview()
                    $0.top.equalTo(titleLabel.snp.bottom)
                    $0.bottom.equalToSuperview()
                }
            }
        }
    }
    
}
