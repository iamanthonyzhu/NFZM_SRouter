//
//  RouterRequest.swift
//  NFZM_SRouter
//
//  Created by anthony zhu on 2023/7/24.
//

import Foundation

public class RouterRequest {
    let url:URL
    let parameters:[String:Any]?
    
    public init(url: URL, parameters: [String : Any]?) {
        self.url = url
        self.parameters = parameters
    }
    
    public convenience init?(scheme:String, host:String, parameters:[String:Any]?) {
        let url:URL? = URL(string: "\(scheme)://\(host)")
        if let curl = url  {
            self.init(url: curl, parameters: parameters)
        } else {
            return nil
        }
    }
}
