//
//  Hexe.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/17/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec

public final class Engine {
    typealias Ptr = OpaquePointer

    let ptr: Ptr

    public init() {
        ptr = Ptr(hexe_engine_new())
    }

    deinit {
        hexe_engine_destroy(UnsafeMutableRawPointer(ptr))
    }
}
