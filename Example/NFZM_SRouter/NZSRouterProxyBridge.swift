//
//  NZSRouterProxyBridge.swift
//  nfzm
//
//  Created by anthony zhu on 2023/7/25.
//  Copyright © 2023 nfzm. All rights reserved.
//

import Foundation
import UIKit
import NFZM_SRouter

@objc enum NZSRetryResult : Int {
    case doNotRetry
    case retry
    case retryWithDelay
}

@objc enum NZRouterError: Int {
    case noError
    case authFailure_unLogin
    case authFailure_authenticateFail
    case authFailure_commonFailure
    case createFailure
    case handleJumpFailure
    case deserializeFailure_noScheme
    case deserializeFailure_noHost
    case deserializeFailure_wrongSchem
}

typealias NZSRouterRetryBlock = (NZSRetryResult, Double) -> Void
typealias NZSRouterCallBack = (NZRouterError,UIViewController?,NZSRouterRetryBlock?) -> Void

@objc class NZSRouterProxyBridge: NSObject {
    static func mapError(_ error:RouterError) -> NZRouterError {
        switch error {
        case .noError:
            return .noError
        case .authFailure(let reason):
            if reason.rawValue == RouterError.AuthFailureReason.unLogin.rawValue {
                return .authFailure_unLogin
            } else if reason.rawValue == RouterError.AuthFailureReason.authFailure.rawValue {
                return .authFailure_authenticateFail
            } else {
                return .authFailure_commonFailure
            }
        case .createFailure:
            return .createFailure
        case .handleJumpFailure:
            return .handleJumpFailure
        case .deserializeFailure(let reason):
            switch reason {
            case .noHost:
                return .deserializeFailure_noHost
            case .noScheme:
                return .deserializeFailure_noScheme
            case .wrongScheme:
                return .deserializeFailure_wrongSchem
            }
        }
    }
    
    @objc static func routerAction(strUrl:NSString,parameters:[String:Any]?,callback: NZSRouterCallBack?) {
        NZSRouterProxy.routerAction(strUrl: String(strUrl), parameters: parameters) { result, completion in
            guard let callbackBlock = callback else {
                return
            }
            guard let compleBlock = completion else {
                if result.isSuccess {
                    callbackBlock(.noError,result.success,nil)
                } else {
                    callbackBlock(self.mapError(result.failure ?? .noError),result.success,nil)
                }
                return
            }
            if result.isSuccess {
                callbackBlock(.noError,result.success) { result, time in
                    compleBlock(.doNotRetry)
                }
            } else {
                callbackBlock(self.mapError(result.failure ?? .noError),result.success) { result,time in
                    switch result {
                    case .doNotRetry:
                        compleBlock(.doNotRetry)
                    case .retry:
                        compleBlock(.retry)
                    case .retryWithDelay:
                        compleBlock(.retryWithDelay(time))
                    }
                }
            }
        }
    }
    
    @objc static func routerAction(scheme:String,host:String,parameters:[String:Any]?,callback:NZSRouterCallBack?) {
        NZSRouterProxy.routerAction(scheme: scheme, host:host, parameters: parameters) { result, completion in
            guard let callbackBlock = callback else {
                return
            }
            guard let compleBlock = completion else {
                if result.isSuccess {
                    callbackBlock(.noError,result.success,nil)
                } else {
                    callbackBlock(self.mapError(result.failure ?? .noError),result.success,nil)
                }
                return
            }
            if result.isSuccess {
                callbackBlock(.noError,result.success) { result, time in
                    compleBlock(.doNotRetry)
                }
            } else {
                callbackBlock(self.mapError(result.failure ?? .noError),result.success) { result,time in
                    switch result {
                    case .doNotRetry:
                        compleBlock(.doNotRetry)
                    case .retry:
                        compleBlock(.retry)
                    case .retryWithDelay:
                        compleBlock(.retryWithDelay(time))
                    }
                }
            }
        }
    }

    @objc static func routerDefaultAction(host:String,parameters:[String:Any]?,callback:NZSRouterCallBack?) {
        NZSRouterProxy.routerDefaultAction(host:host, parameters: parameters) { result, completion in
            guard let callbackBlock = callback else {
                return
            }
            guard let compleBlock = completion else {
                if result.isSuccess {
                    callbackBlock(.noError,result.success,nil)
                } else {
                    callbackBlock(self.mapError(result.failure ?? .noError),result.success,nil)
                }
                return
            }
            if result.isSuccess {
                callbackBlock(.noError,result.success) { result, time in
                    compleBlock(.doNotRetry)
                }
            } else {
                callbackBlock(self.mapError(result.failure ?? .noError),result.success) { result,time in
                    switch result {
                    case .doNotRetry:
                        compleBlock(.doNotRetry)
                    case .retry:
                        compleBlock(.retry)
                    case .retryWithDelay:
                        compleBlock(.retryWithDelay(time))
                    }
                }
            }
        }
    }
}
