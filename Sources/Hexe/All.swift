//
//  All.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 3/6/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

/// A type whose instances can be iterated over via `All<Self>`.
public protocol AllIterable {
    /// An iterator over all instances of this type.
    static var all: All<Self> { get }
}

/// An iterator over all instances of `T`.
public struct All<T: AllIterable>: IteratorProtocol, Sequence {

    private var current: UInt8 = 0

    private let total: UInt8

    public var underestimatedCount: Int {
        return Range(uncheckedBounds: (current, total)).count
    }

    fileprivate init(_ total: UInt8) {
        self.total = total
    }

    public mutating func next() -> T? {
        guard self.current < self.total else {
            return nil
        }
        let next = self.current
        self.current = next &+ 1
        return unsafeBitCast(next, to: T.self)
    }

}

extension Square: AllIterable {
    internal static let _count: UInt8 = 64

    public static let all = All<Square>(_count)
}

extension Color: AllIterable {
    internal static let _count: UInt8 = 2

    public static let all = All<Color>(_count)
}

extension PieceKind: AllIterable {
    internal static let _count: UInt8 = 6

    public static let all = All<PieceKind>(_count)
}

extension Piece: AllIterable {
    internal static let _count = PieceKind._count * Color._count

    public static let all = All<Piece>(_count)
}

extension CastleRight: AllIterable {
    internal static let _count: UInt8 = 4

    public static let all = All<CastleRight>(_count)
}
