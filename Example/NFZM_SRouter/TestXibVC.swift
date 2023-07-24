//
//  TestXibVC.swift
//  NFZM_SRouter_Example
//
//  Created by anthony zhu on 2023/7/24.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import NFZM_SRouter

class TestXibVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension TestXibVC:RouterProtocol {
//    static public func schemeForRouter() -> String {
//        NZSRouterProxy.NZSPermitScheme.defaultScheme
//    }
    
    static public func targetConfigForRouter() -> (action:RouterActionType, vcType:RouterVCType) {
        (RouterActionType.push(true),.rXib(fileName: "TestXibVC", bundlePath: Bundle.main))
    }
    
    public func handleRouterAuthentication() -> RouterError {
        return .noError
    }

    public func canHandle(parameters:[String:Any]?) -> Bool {
        true
    }
    
    @discardableResult public func handleRouter(parameters:[String:Any]?) -> RouterResult<UIViewController> {
        RouterResult.success(self)
    }
    
    @discardableResult public func handleCustomShow(sourceVC:UIViewController) -> RouterResult<UIViewController> {
//        sourceVC.view.addSubview(self.view)
//        self.view.backgroundColor = UIColor.blue
        return RouterResult.success(self)
    }
}
