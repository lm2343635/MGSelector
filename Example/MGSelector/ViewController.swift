//
//  ViewController.swift
//  MGSelector
//
//  Created by Meng Li on 10/01/2018.
//  Copyright © 2018 MuShare. All rights reserved.
//

import UIKit
import MGSelector

fileprivate struct HeaderKeys: MGSelectorOption {
    var icon: UIImage? = UIImage(systemName: "figure")
    var title: String
    var tag: String?
    var detail: String?
}

fileprivate struct Const {
    static let keys = ["Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language",
                             "Accept-Datetime", "Authorization", "Cache-Control", "Connection",
                             "Cookie", "Connection", "Content-Length", "Content-MD5", "Content-Type",
                             "Date", "Expect", "Forwarded", "From", "Host", "If-Match", "If-Modified-Since",
                             "If-None-Match", "If-Range", "If-Unmodified-Since", "Max-Forwards",
                             "Origin", "Pragma", "Proxy-Authorization", "Range", "Referer",
                             "User-Agent", "Upgrade", "Via", "Warning"]
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
            openSelector(
                title: "Header Keys",
                options: Const.keys.map { HeaderKeys(title: $0, tag: "VIP", detail: nil) },
                mode: .single(selectedIndex: Const.keys.firstIndex(of: title ?? "") ?? 0)
            )
        case darkButton:
            openSelector(
                title: "Header Keys",
                options: Const.keys.map { HeaderKeys(title: $0, detail: NSLocalizedString($0, comment: "")) },
                mode: .multiple(selectedIndexes: [0, 1]),
                theme: .dark()
            )
        default:
            break
        }
    }
    
}

extension ViewController: MGSelectable {
    
    func didSelect(options: [MGSelectorOption]) {
        title = options.map { $0.title }.reduce("", +)
    }
    
}
