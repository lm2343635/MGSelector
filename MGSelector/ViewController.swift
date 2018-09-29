//
//  ViewController.swift
//  MGSelector
//
//  Created by lm2343635 on 10/01/2018.
//  Copyright (c) 2018 lm2343635. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MGSelectable {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func open(_ sender: Any) {
        openSelector()
    }
    
}

