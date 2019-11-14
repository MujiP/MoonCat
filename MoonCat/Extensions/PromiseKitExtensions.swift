//
//  PromiseKitExtensions.swift
//
//  Created by Muji Paracha on 2019-08-01.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import PromiseKit
import Bifrost

extension Resolver {
    
    /*
     A convenience method to use with our Bifrost Result objects.
     */
    
    func resolve(_ result: Bifrost.Result<T>) {
        switch result {
        case .success(let obj):
            self.fulfill(obj)
        case .failure(let error):
            self.reject(error)
        }
    }
}


extension Requestable {
    func run() -> Promise<ExpectedObjType> {
        return Promise { seal in
            self.run { seal.resolve($0) }
        }
    }
}

extension ParsedRequestable {
    func run() -> Promise<ParsedType> {
        return Promise { seal in
            self.run { seal.resolve($0) }
        }
    }
}

extension ImageRequestable {
    func run() -> Promise<UIImage> {
        return Promise { seal in
            self.run { seal.resolve($0) }
        }
    }
}
