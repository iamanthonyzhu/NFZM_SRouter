//
//  Error+Router.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

public enum RouterError: Error {
    case noError
    public enum AuthFailureReason {
        case unlogin
    }
    case authFailure(reason:AuthFailureReason)
}

