//
//  RouterProtocol.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

public enum RouterVCType {
    case rClass(clsName:String)
    case rXib(fileName:String, bundlePath:String, identifier:String)
    case rStoryboard(fileName:String, bundlePath:String, identifier:String)
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
