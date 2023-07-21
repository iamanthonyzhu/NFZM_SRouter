//
//  RouterCore.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

public typealias TargetConfig = (action:RouterActionType, vcType:RouterVCType)
public typealias RouterCallback = (_ result:RouterResult<UIViewController>, _ completion: @escaping (RetryResult) -> Void) -> Void

public enum RetryResult {
    /// Retry should be attempted immediately.
    case retry
    /// Retry should be attempted after the associated `TimeInterval`.
    case retryWithDelay(TimeInterval)
    /// Do not retry.
    case doNotRetry
}

extension RetryResult {
    var retryRequired: Bool {
        switch self {
        case .retry, .retryWithDelay: return true
        default: return false
        }
    }

    var delay: TimeInterval? {
        switch self {
        case let .retryWithDelay(delay): return delay
        default: return nil
        }
    }

}


class RouterFactory {
    static func createViewController(targetConfig:TargetConfig) -> UIViewController? {
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


public class RouterCore {
    static public func gotoViewController(targetConfig:TargetConfig,
                                 parameters:[String:Any]?,
                                 sourceVC:UIViewController,
                                 callback:@escaping RouterCallback) -> Void {
        let vc = RouterFactory.createViewController(targetConfig: targetConfig)
        
        let retryBlock:(RetryResult) -> Void = { result in
            switch result {
            case .doNotRetry:
                return
            case .retry:
                RouterCore.gotoViewController(targetConfig: targetConfig, parameters: parameters, sourceVC: sourceVC, callback: callback)
            case .retryWithDelay(let time):
                DispatchQueue.main.after(time) {
                    RouterCore.gotoViewController(targetConfig: targetConfig, parameters: parameters, sourceVC: sourceVC, callback: callback)
                }
            }
            
        }
        if let targetVC = vc {
            do {
                try self.handleShow(sourceVC: sourceVC, targetVC: targetVC, actType: targetConfig.action)
                callback(RouterResult.success(targetVC), retryBlock)
            } catch {
                callback(RouterResult.failure(RouterError.handleJumpFailure),retryBlock)
            }
        } else {
            callback(RouterResult.failure(RouterError.createFailure),retryBlock)
        }
    }
    
    @discardableResult static func handleShow(sourceVC:UIViewController,targetVC:UIViewController,actType:RouterActionType) throws -> UIViewController {
        var result = RouterResult.success(targetVC)
        switch actType {
        case let .push(anim):
            if let nav = sourceVC.navigationController {
                nav.pushViewController(targetVC, animated: anim)
            } else {
                result = RouterResult.failure(RouterError.handleJumpFailure)
            }
        case let .present(anim):
            if let nav = sourceVC.navigationController {
                nav.present(targetVC, animated: anim)
            } else {
                result = RouterResult.failure(RouterError.handleJumpFailure)
            }
        case .custom:
            result = targetVC.handleCustomShow(sourceVC: sourceVC)
        }
        if result.isSuccess {
            return result.success!
        }
        throw result.failure!
    }
}
