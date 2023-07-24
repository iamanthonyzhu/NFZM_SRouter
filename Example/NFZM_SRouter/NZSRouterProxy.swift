//
//  NZSRouterProxy.swift
//  NFZM_SRouter_Example
//
//  Created by anthony zhu on 2023/7/24.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import NFZM_SRouter

extension RouterError.AuthFailureReason {
    static let unLogin = RouterError.AuthFailureReason(rawValue: "unLogin")
    static let authFailure = RouterError.AuthFailureReason(rawValue: "authenticationFailure")
}


public class NZSRouterProxy {
    public struct NZSPermitScheme {
        static let defaultScheme = "NFZMSRouter"
    }

    static let sessin:RouterSession = RouterSession(permitSchemes:[NZSPermitScheme.defaultScheme])
    
    static func routerAction(strUrl:String,parameters:[String:Any]?,callback:@escaping RouterCallback) {
        let url : URL? = URL(string: strUrl)
        var param:[String:Any] = [:]
        if let exParam = parameters {
            param.merge(exParam) { _, last in
                last
            }
        }
        if let curl = url {
            if let components = URLComponents(url: curl, resolvingAgainstBaseURL: false) {
                if let items = components.queryItems {
                    for item in items {
                        if let value = item.value {
                            param.updateValue(value, forKey: item.name)
                        }
                    }
                }
            }

            let request:RouterRequest? = RouterRequest(url: curl, parameters: param)
            if let req = request,let sourceVC = UIViewController.getCurrentViewController() {
                sessin.request(request: req, from: sourceVC,callback: callback)
            }
        }
    }
    
    static func routerAction(scheme:String,host:String,parameters:[String:Any]?,callback:@escaping RouterCallback) {
        let request:RouterRequest? = RouterRequest(scheme: scheme, host: host, parameters: parameters)
        if let req = request,let sourceVC = UIViewController.getCurrentViewController() {
            sessin.request(request: req, from: sourceVC,callback: callback)
        }
    }

    static func routerDefaultAction(host:String,parameters:[String:Any]?,callback:@escaping RouterCallback) {
        let request:RouterRequest? = RouterRequest(scheme: NZSPermitScheme.defaultScheme, host: host, parameters: parameters)
        if let req = request,let sourceVC = UIViewController.getCurrentViewController() {
            sessin.request(request: req, from: sourceVC,callback: callback)
        }
    }

}

extension UIViewController {
    class func getCurrentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return getCurrentViewController(base: nav.visibleViewController)
            }
            if let tab = base as? UITabBarController {
                return getCurrentViewController(base: tab.selectedViewController)
            }
            if let presented = base?.presentedViewController {
                return getCurrentViewController(base: presented)
            }
            return base
        }
}
