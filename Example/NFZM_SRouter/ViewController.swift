//
//  ViewController.swift
//  NFZM_SRouter
//
//  Created by 朱伟 on 07/20/2023.
//  Copyright (c) 2023 朱伟. All rights reserved.
//

import UIKit
import NFZM_SRouter

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = RouterClassContainer.routerToVCName("TestVC")
        if let target = vc {
            self.pushViewController(target, animated: true)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
