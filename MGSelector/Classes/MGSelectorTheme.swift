//
//  MGSelectorTheme.swift
//  MGSelector
//
//  Created by Meng Li on 2018/10/1.
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

public struct MGSelectorTheme {
    var maskColor: UIColor
    var backgroundColor: UIColor
    var mainColor: UIColor
    var secondaryColor: UIColor
    var tagTextColor: UIColor
    var tagBackgroundColor: UIColor
    
    public init(
        maskColor: UIColor,
        backgroundColor: UIColor,
        mainColor: UIColor,
        secondaryColor: UIColor,
        tagTextColor: UIColor,
        tagBackgroundColor: UIColor
    ) {
        self.maskColor = maskColor
        self.backgroundColor = backgroundColor
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        self.tagTextColor = tagTextColor
        self.tagBackgroundColor = tagBackgroundColor
    }
    
    public static func light(tagBackgroundColor: UIColor = .darkGray) -> MGSelectorTheme {
        return MGSelectorTheme(
            maskColor: UIColor(white: 0, alpha: 0.7),
            backgroundColor: .white,
            mainColor: .black,
            secondaryColor: .darkGray,
            tagTextColor: .white,
            tagBackgroundColor: tagBackgroundColor
        )
    }
    
    public static func dark(tagBackgroundColor: UIColor = .lightGray) -> MGSelectorTheme {
        return MGSelectorTheme(
            maskColor: UIColor(white: 0, alpha: 0.5),
            backgroundColor: .darkGray,
            mainColor: .white,
            secondaryColor: .lightGray,
            tagTextColor: .white,
            tagBackgroundColor: tagBackgroundColor
        )
    }
    
    public static func automatic(tagBackgroundColor: UIColor = .darkGray) -> MGSelectorTheme {
        return MGSelectorTheme(
            maskColor: UIColor(dynamicProvider: { t in
                if t.userInterfaceStyle == .dark {
                    return UIColor(white: 0, alpha: 0.5)
                } else {
                    return UIColor(white: 0, alpha: 0.7)
                }
            }),
            backgroundColor: UIColor(dynamicProvider: { t in
                if t.userInterfaceStyle == .dark {
                    return .darkGray
                } else {
                    return .white
                }
            }),
            mainColor: UIColor(dynamicProvider: { t in
                if t.userInterfaceStyle == .dark {
                    return .white
                } else {
                    return .black
                }
            }),
            secondaryColor: UIColor(dynamicProvider: { t in
                if t.userInterfaceStyle == .dark {
                    return .lightGray
                } else {
                    return .darkGray
                }
            }),
            tagTextColor: .white,
            tagBackgroundColor: tagBackgroundColor
        )
    }
    
}
