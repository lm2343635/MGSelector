//
//  MGSelectable.swift
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

public enum MGSelectorMode {
    case single(selectedIndex: Int)
    case multiple(selectedIndexes: [Int])
}

public protocol MGSelectorOption {
    var icon: UIImage? { get }
    var title: String { get }
    var tag: String? { get }
    var detail: String? { get }
}

public protocol MGSelectable: AnyObject {
    func didSelect(options: [MGSelectorOption])
}

extension MGSelectable where Self: UIViewController {
    
    public func openSelector(
        title: String?,
        options: [MGSelectorOption],
        mode: MGSelectorMode = .single(selectedIndex: 0),
        theme: MGSelectorTheme = .light()
    ) {
        let selector = MGSelectorViewController(
            title: title,
            options: options,
            mode: mode,
            theme: theme
        )
        selector.delegate = self
        present(selector, animated: true)
    }

}

struct MGSelectorItem {
    let option: MGSelectorOption
    let selected: Bool
}
