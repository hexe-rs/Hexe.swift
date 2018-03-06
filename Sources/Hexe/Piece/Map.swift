//
//  Map.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec
import simd

private typealias Simd = simd_uint4

private let simdCount: Int = MemoryLayout<piece_map>.size / MemoryLayout<Simd>.size
private let noPiece: UInt8 = 12

private let lo32: UInt32 = 0x1010101
private let hi32: UInt32 = lo32 << 7

private func memEq(_ lhs: UnsafePointer<piece_map>, _ rhs: UnsafePointer<piece_map>) -> Bool {
    let a = simdPointer(to: lhs)
    let b = simdPointer(to: rhs)
    for i in 0 ..< simdCount {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}

private func simdPointer(to map: UnsafePointer<piece_map>) -> UnsafePointer<Simd> {
    return map.withMemoryRebound(to: Simd.self, capacity: simdCount, { $0 })
}

private func pointer(in map: UnsafeMutableRawPointer, to sq: Square) -> UnsafeMutableRawPointer {
    return map + Int(sq.rawValue)
}

/// A mapping of sixty-four squares to pieces.
public final class PieceMap: Equatable {
    /// Returns whether the piece maps are equal.
    public static func == (lhs: PieceMap, rhs: PieceMap) -> Bool {
        return lhs === rhs || memEq(&lhs.inner, &rhs.inner)
    }

    /// The piece map for standard chess.
    public static var standard: PieceMap {
        return PieceMap(inner: hexe_piece_map_standard())
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

    /// Returns a boolean indicating whether the map is empty.
    public var isEmpty: Bool {
        let empty = Simd(lo32 * UInt32(noPiece))
        let inner = simdPointer(to: &self.inner)
        for i in 0 ..< simdCount {
            if inner[i] != empty {
                return false
            }
        }
        return true
    }

    private init(inner: piece_map) {
        self.inner = inner
    }

    /// Creates a new instance.
    public init() {
        self.inner = hexe_piece_map_new()
    }

    /// Creates a copy from `other`.
    public init(other: PieceMap) {
        self.inner = other.inner
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
