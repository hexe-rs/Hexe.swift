//
//  Engine.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/17/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec

/// An instance of the Hexe chess engine.
public final class Engine {
    /// A pointer to the engine, represented as `Box<Engine>` in Rustland
    let ptr: engine_ptr

    /// Creates a new instance.
    public init() {
        ptr = hexe_engine_new()
    }

    deinit {
        hexe_engine_destroy(ptr)
    }
}
