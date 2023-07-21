//
//  RouterClassContainer.swift
//  Pods-NFZM_SRouter_Example
//
//  Created by anthony zhu on 2023/7/20.
//

import Foundation


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
