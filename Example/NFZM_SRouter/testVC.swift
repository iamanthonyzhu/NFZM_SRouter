//
//  TestVC.swift
//  NFZM_SRouter_Example
//
//  Created by anthony zhu on 2023/7/20.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import NFZM_SRouter

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension TestVC:RouterProtocol {
    static public func schemeForRouter() -> String {
        "NFZMSRouter"
    }
    
    static public func targetConfigForRouter() -> (action:RouterActionType, vcType:RouterVCType) {
        (RouterActionType.present(true),.rClass(clsName: NSStringFromClass(TestVC.self)))
    }
    
    public func handleRouterAuthentication() -> RouterError {
        .noError
    }

    public func canHandle(parameters:[String:Any]?) -> Bool {
        true
    }
    
    @discardableResult public func handleRouter(parameters:[String:Any]?) -> RouterResult<UIViewController> {
        RouterResult.success(self)
    }
    
    @discardableResult public func handleCustomShow(sourceVC:UIViewController) -> RouterResult<UIViewController> {
        RouterResult.success(self)
    }
}
