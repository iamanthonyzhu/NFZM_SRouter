//
//  RouterClassContainer.swift
//  Pods-NFZM_SRouter_Example
//
//  Created by anthony zhu on 2023/7/20.
//

import Foundation

extension UIViewController :RouterProtocol {
    
    func schemeForRouter() -> String {
        RouterClassContainer.AssociatedKeys.defaultScheme
    }
    
    func targetConfigForRouter() -> (action:RouterActionType, vcType:RouterVCType) {
        (RouterActionType.push,.rClass(clsName: NSStringFromClass(type(of: self))))
    }
    
    func handleRouterAuthentication() -> RouterError {
        .noError
    }

    func canhandle(parameters:[String:String]) -> RouterResult<UIViewController> {
        RouterResult(value: self, error: nil)
    }
    
    func handleRouter(parameters:[String:String]) -> RouterResult<UIViewController> {
        RouterResult(value: self, error: nil)
    }
    
    func handleCustomShow(sourceVC:UIViewController,targetVC:UIViewController) -> RouterResult<UIViewController> {
        RouterResult(value: self, error: nil)
    }

}

public class RouterClassContainer : NSObject {
    
    static let shared = RouterClassContainer()
    
    struct AssociatedKeys {
        static var defaultScheme = "NZSRouter"
    }

    
    var schemes:[String] = [AssociatedKeys.defaultScheme]

    override private init() {
        
    }
    
    public func addScheme(_ schemes:[String]) -> Void {
        self.schemes.append(contentsOf: schemes)
    }

    public static func routerToVCName(_ clsName:String) -> UIViewController? {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let cls = NSClassFromString("\(namespace).\(clsName)") as? UIViewController.Type
        if let realCls = cls {
            return realCls.init(nibName: nil, bundle: nil)
        }
        return nil
    }
}
