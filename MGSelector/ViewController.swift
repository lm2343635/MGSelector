//
//  ViewController.swift
//  MGSelector
//
//  Created by lm2343635 on 10/01/2018.
//  Copyright (c) 2018 lm2343635. All rights reserved.
//

import UIKit

fileprivate struct HeaderKeys {
    var key: String
}

extension HeaderKeys: MGSelectorOption {
    
    var title: String {
        return key
    }
    
    var detail: String? {
        return NSLocalizedString(key, comment: "")
    }
    
}

fileprivate struct Const {
    static let keys = ["Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language",
                             "Accept-Datetime", "Authorization", "Cache-Control", "Connection",
                             "Cookie", "Connection", "Content-Length", "Content-MD5", "Content-Type",
                             "Date", "Expect", "Forwarded", "From", "Host", "If-Match", "If-Modified-Since",
                             "If-None-Match", "If-Range", "If-Unmodified-Since", "Max-Forwards",
                             "Origin", "Pragma", "Proxy-Authorization", "Range", "Referer",
                             "User-Agent", "Upgrade", "Via", "Warning"]
    
    static let headerKeys = keys.map { HeaderKeys(key: $0) }
}

class ViewController: UIViewController {

    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var darkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func open(_ sender: UIButton) {
        switch sender {
        case lightButton:
            openSelector(title: "Header Keys", options: Const.headerKeys)
        case darkButton:
            openSelector(title: "Header Keys", options: Const.headerKeys, theme: .dark)
        default:
            break
        }
    }
    
}

extension ViewController: MGSelectable {
    
    func didSelect(option: MGSelectorOption) {
        title = option.title
    }
    
}
