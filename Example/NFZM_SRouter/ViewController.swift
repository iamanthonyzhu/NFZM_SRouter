//
//  ViewController.swift
//  NFZM_SRouter
//
//  Created by 朱伟 on 07/20/2023.
//  Copyright (c) 2023 朱伟. All rights reserved.
//

import UIKit
import NFZM_SRouter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NZSRouterProxy.routerAction(strUrl: "NFZMSRouter://TestVC?abc=1&def=abc", parameters: ["ghi":12,"gfg":self]) { result, completion in
        //NZSRouterProxy.routerDefaultAction(host: "TestVC", parameters: nil) { result, completion in
            print(result)
            guard let compBlock = completion else {
                return
            }
            if result.isSuccess {
                compBlock(.doNotRetry)
            } else {
                //compBlock(.doNotRetry)
                compBlock(.retryWithDelay(5.0))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

