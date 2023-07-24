//
//  RouterSession.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/24.
//

import Foundation

public class RouterSession {
    let permitSchemes:[String]
    public init(permitSchemes: [String]) {
        self.permitSchemes = permitSchemes
    }
    public func request(request:RouterRequest,from sourceVC:UIViewController,callback:@escaping RouterCallback) {
        guard let targetScheme = request.url.scheme else {
            callback(RouterResult.failure(RouterError.deserializeFailure(.noScheme)), nil)
            return
        }
        guard let clsName = request.url.host  else {
            callback(RouterResult.failure(RouterError.deserializeFailure(.noHost)), nil)
            return
        }
        if self.permitSchemes.contains(targetScheme) {
            RouterCore.gotoViewController(clsName: clsName, parameters: request.parameters, sourceVC: sourceVC, callback: callback)
        } else {
            callback(RouterResult.failure(RouterError.deserializeFailure(.wrongScheme)), nil)
        }
        
    }
    
}
