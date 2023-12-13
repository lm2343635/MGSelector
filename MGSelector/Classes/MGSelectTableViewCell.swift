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

class TagLabel: UILabel {

    var textInsets: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(
            width: originalSize.width + textInsets.left + textInsets.right,
            height: originalSize.height + textInsets.top + textInsets.bottom
        )
    }
}


class MGSelectTableViewCell: UITableViewCell {
    
    private lazy var iconImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = TagLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        label.font = .systemFont(ofSize: 12)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(tagLabel)
        addSubview(detailLabel)
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(26)
        }
        
        tagLabel.snp.makeConstraints {
            $0.right.lessThanOrEqualToSuperview().offset(-50)
            $0.centerY.equalTo(titleLabel)
            $0.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var theme: MGSelectorTheme = .light() {
        didSet {
            titleLabel.textColor = theme.mainColor
            detailLabel.textColor = theme.secondaryColor
            tagLabel.textColor = theme.tagTextColor
            tagLabel.backgroundColor = theme.tagBackgroundColor
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
            tagLabel.text = item.option.tag
            tagLabel.isHidden = item.option.tag == nil
            if let detail = item.option.detail {
                detailLabel.text = detail
                
                titleLabel.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(item.option.icon == nil ? 0 : 40)
                    $0.right.equalTo(tagLabel.snp.left).offset(-10)
                    $0.top.equalToSuperview().offset(5)
                }
                
                detailLabel.snp.makeConstraints {
                    $0.left.equalTo(titleLabel)
                    $0.right.equalToSuperview().offset(-50)
                    $0.top.equalTo(titleLabel.snp.bottom).offset(5)
                    $0.bottom.equalToSuperview().offset(-5)
                }
            } else {
                titleLabel.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(item.option.icon == nil ? 0 : 40)
                    $0.top.bottom.equalToSuperview()
                    $0.right.equalTo(tagLabel.snp.left).offset(-10)
                    $0.height.equalTo(50)
                }
            }
        }
    }
    
}
