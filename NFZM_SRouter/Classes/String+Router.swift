//
//  String+Router.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

extension String {
    func mainBundleRouterVC() -> RouterProtocol.Type? {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        return NSClassFromString("\(namespace).\(self)") as? RouterProtocol.Type
    }
}
