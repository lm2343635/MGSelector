//
//  MGSelectable.swift
//  MGSelector
//
//  Created by Meng Li on 2018/10/01.
//

import UIKit

public protocol MGSelectorOption {
    var title: String { get }
    var detail: String? { get }
}

public protocol MGSelectable: class {
    func didSelect(option: MGSelectorOption)
}

public extension MGSelectable where Self: UIViewController {
    
    public func openSelector(title: String, options: [MGSelectorOption], theme: MGSelectorTheme = .light) {
        let selector = MGSelectorViewController(title: title, options: options, theme: theme)
        selector.delegate = self
        present(selector, animated: true)
    }
}
