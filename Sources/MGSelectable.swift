//
//  MGSelectable.swift
//  MGSelector
//
//  Created by Meng Li on 2018/10/01.
//

import UIKit

public protocol MGSelectable {}

public extension MGSelectable where Self: UIViewController {
    
    public func openSelector() {
        let selector = MGSelectorViewController()
        present(selector, animated: true)
    }
}
