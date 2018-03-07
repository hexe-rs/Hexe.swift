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

    private var iter: CountableRange<UInt8>.Iterator

    public var underestimatedCount: Int {
        return self.iter.underestimatedCount
    }

    fileprivate init(_ total: UInt8) {
        self.iter = (0 ..< total).makeIterator()
    }

    public mutating func next() -> T? {
        guard let next = self.iter.next() else {
            return nil
        }
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
