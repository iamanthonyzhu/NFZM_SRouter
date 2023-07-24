//
//  Error+Router.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/21.
//

import Foundation

public enum RouterError: Error {
    case noError
    public struct AuthFailureReason {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        static let commonFailure = AuthFailureReason(rawValue: "commonFailure")
    }

    public enum DesializelFailureReason {
        case noScheme
        case noHost
        case wrongScheme
    }
    case authFailure(_ reason:AuthFailureReason)
    case createFailure
    case handleJumpFailure
    case deserializeFailure(_ reason:DesializelFailureReason)
}


