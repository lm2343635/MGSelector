//
//  MGSelectorTheme.swift
//  MGSelector_Example
//
//  Created by Meng Li on 2018/10/1.
//  Copyright © 2018 MuShare. All rights reserved.
//

import UIKit

public struct MGSelectorTheme {
    var maskColor: UIColor
    var backgroundColor: UIColor
    var mainColor: UIColor
    var secondaryColor: UIColor
    
    public static let light = MGSelectorTheme(maskColor: UIColor(white: 0, alpha: 0.7), backgroundColor: .white, mainColor: .black, secondaryColor: .darkGray)
    public static let dark = MGSelectorTheme(maskColor: UIColor(white: 0, alpha: 0.5),backgroundColor: .darkGray, mainColor: .white, secondaryColor: .lightGray)
    
}
