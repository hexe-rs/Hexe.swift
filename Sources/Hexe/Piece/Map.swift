//
//  Map.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec

func memEq<T>(_ lhs: UnsafePointer<T>, _ rhs: UnsafePointer<T>) -> Bool {
    return Int(bitPattern: lhs) == Int(bitPattern: rhs)
        || memcmp(lhs, rhs, MemoryLayout<T>.size) == 0
}

/// A mapping of sixty-four squares to pieces.
public final class PieceMap: Equatable {
    /// Returns whether the piece maps are equal.
    public static func == (lhs: PieceMap, rhs: PieceMap) -> Bool {
        return memEq(&lhs.inner, &rhs.inner)
    }

    private var inner: piece_map

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
