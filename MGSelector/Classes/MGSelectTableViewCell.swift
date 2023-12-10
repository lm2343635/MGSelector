//
//  MGSelectTableViewCell.swift
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

class MGSelectTableViewCell: UITableViewCell {
    
    private lazy var iconImageView = UIImageView()
    
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
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailTextView)
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(26)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var theme: MGSelectorTheme = .light {
        didSet {
            titleLabel.textColor = theme.mainColor
            detailTextView.textColor = theme.secondaryColor
        }
    }
    
    var item: MGSelectorItem? {
        didSet {
            guard let item = item else {
                return
            }
            accessoryType = item.selected ? .checkmark : .none
            iconImageView.image = item.option.icon
            titleLabel.text = item.option.title
            if let detail = item.option.detail {
                detailTextView.text = detail
                detailTextView.snp.makeConstraints {
                    $0.left.equalToSuperview()
                    $0.right.equalToSuperview()
                    $0.top.equalTo(titleLabel.snp.bottom)
                    $0.bottom.equalToSuperview()
                }
                
                titleLabel.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(item.option.icon == nil ? 0 : 40)
                    $0.right.equalToSuperview()
                    $0.top.equalToSuperview()
                }
            } else {
                titleLabel.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(item.option.icon == nil ? 0 : 40)
                    $0.top.right.bottom.equalToSuperview()
                    $0.height.equalTo(50)
                }
            }
        }
    }
    
}
