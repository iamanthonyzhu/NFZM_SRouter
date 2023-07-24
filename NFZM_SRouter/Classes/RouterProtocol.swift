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
    case push(_ anim:Bool)
    case present(_ anim:Bool)
    case custom
}

public protocol RouterProtocol : UIViewController {
    
    //static func schemeForRouter() -> String
    
    static func targetConfigForRouter() -> (action:RouterActionType, vcType:RouterVCType)
    
    func handleRouterAuthentication() -> RouterError
    
    func canHandle(parameters:[String:Any]?) -> Bool
    
    @discardableResult func handleRouter(parameters:[String:Any]?) -> RouterResult<UIViewController>
    
    @discardableResult func handleCustomShow(sourceVC:UIViewController) -> RouterResult<UIViewController>
    
}


//extension UIViewController :RouterProtocol {
//    
//    public func schemeForRouter() -> String {
//        RouterClassContainer.AssociatedKeys.defaultScheme
//    }
//    
//    public func targetConfigForRouter() -> (action:RouterActionType, vcType:RouterVCType) {
//        (RouterActionType.push(true),.rClass(clsName: NSStringFromClass(type(of: self))))
//    }
//    
//    public func handleRouterAuthentication() -> RouterError {
//        .noError
//    }
//
//    public func canHandle(parameters:[String:String]) -> Bool {
//        true
//    }
//    
//    @discardableResult public func handleRouter(parameters:[String:String]) -> RouterResult<UIViewController> {
//        RouterResult.success(self)
//    }
//    
//    @discardableResult public func handleCustomShow(sourceVC:UIViewController) -> RouterResult<UIViewController> {
//        RouterResult.success(self)
//    }
//
//}
