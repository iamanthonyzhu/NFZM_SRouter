//
//  RouterProtocol.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

public enum RouterVCType {
    case rClass(clsName:String)
    case rXib(fileName:String, bundlePath:Bundle?)
    case rStoryboard(fileName:String, bundlePath:Bundle?, identifier:String)
}

public enum RouterActionType {
    case push
    case present
    case custom
}

protocol RouterProtocol : AnyObject {
    
    func schemeForRouter() -> String
    
    func targetConfigForRouter() -> (action:RouterActionType, vcType:RouterVCType)
    
    func handleRouterAuthentication() -> RouterError
    
    func canhandle(parameters:[String:String]) -> RouterResult<UIViewController>
    
    func handleRouter(parameters:[String:String]) -> RouterResult<UIViewController>
    
    func handleCustomShow(sourceVC:UIViewController,targetVC:UIViewController) -> RouterResult<UIViewController>
    
}


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
