//
//  RouterCore.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

class RouterFactory {
    static func createViewController(targetConfig:(action:RouterActionType, vcType:RouterVCType)) -> UIViewController? {
        let (_, vcType) = targetConfig
        switch vcType {
        case let .rClass(clsName):
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let cls = NSClassFromString("\(namespace).\(clsName)") as? UIViewController.Type
            if let realCls = cls {
                return realCls.init(nibName: nil, bundle: nil)
            }
        case let .rStoryboard(fileName,bundlePath,identifier):
            if #available(iOS 13.0, *) {
                return UIStoryboard(name: fileName, bundle: bundlePath).instantiateViewController(identifier:identifier)
            }
        case let .rXib(fileName,bundlePath):
            return UIViewController.init(nibName: fileName, bundle: bundlePath)
        }
        return nil
    }
}
