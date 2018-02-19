//
//  Map.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec
import simd

typealias Simd = simd_uint4

private func memEq(_ lhs: UnsafePointer<piece_map>, _ rhs: UnsafePointer<piece_map>) -> Bool {
    if Int(bitPattern: lhs) == Int(bitPattern: rhs) {
        return true
    }
    let len = MemoryLayout<piece_map>.size / MemoryLayout<Simd>.size
    return lhs.withMemoryRebound(to: Simd.self, capacity: len) { a in
        rhs.withMemoryRebound(to: Simd.self, capacity: len) { b in
            for i in 0 ..< len {
                if a[i] != b[i] {
                    return false
                }
            }
            return true
        }
    }
}

/// A mapping of sixty-four squares to pieces.
public final class PieceMap: Equatable {
    /// Returns whether the piece maps are equal.
    public static func == (lhs: PieceMap, rhs: PieceMap) -> Bool {
        return memEq(&lhs.inner, &rhs.inner)
    }

    private var inner: piece_map

    /// Creates the fen string for `self`.
    public var fen: String {
        var s: String = ""
        return withUnsafeMutablePointer(to: &s) {
            let ptr: UnsafeMutablePointer<String> = $0
            hexe_piece_map_fen(ptr, &self.inner) {
                let p = $1.assumingMemoryBound(to: String.self)
                p.pointee = String(cString: $0)
            }
            return s
        }
    }

    /// Creates a new instance.
    public init() {
        self.inner = hexe_piece_map_new()
    }

    /// Retrieves the piece at the square.
    public subscript(square: Square) -> Piece? {
        get {
            let ptr = pointer(in: &self.inner, to: square)
            switch ptr.load(as: UInt8.self) {
            case 13:
                return nil
            case let other:
                return unsafeBitCast(other, to: Piece.self)
            }
        }
        set {
            let ptr = pointer(in: &self.inner, to: square).assumingMemoryBound(to: UInt8.self)
            if let pc = newValue {
                ptr.pointee = pc.rawValue
            } else {
                ptr.pointee = 13
            }
        }
    }
}

private func pointer(in map: UnsafeMutableRawPointer, to sq: Square) -> UnsafeMutableRawPointer {
    return map + Int(sq.rawValue)
}
