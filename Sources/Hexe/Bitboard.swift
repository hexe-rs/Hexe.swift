//
//  Bitboard.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

/// A bitmap chess board representation.
public struct Bitboard: RawRepresentable, Equatable {
    /// A full bitboard.
    public static let full = Bitboard(~0)

    /// An empty bitboard.
    public static let empty = Bitboard(0)

    /// The inner raw value.
    public var rawValue: UInt64

    /// Returns an iterator over the subsets of `self`.
    public var carryRippler: CarryRippler {
        return CarryRippler(self)
    }

    /// Returns the number of bits set.
    public var count: Int {
        return self.rawValue.nonzeroBitCount
    }

    /// Returns whether `self` is empty.
    public var isEmpty: Bool {
        return self.rawValue == 0
    }

    /// Returns whether `self` has multiple bits set.
    public var hasMultiple: Bool {
        return self.rawValue & (self.rawValue &- 1) != 0
    }

    /// Creates an instance from `rawValue`.
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }

    /// Creates an instance from `rawValue`.
    public init(_ rawValue: UInt64) {
        self.rawValue = rawValue
    }
}

extension Bitboard: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

extension Bitboard: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: UInt64) {
        self.init(value)
    }
}

extension Bitboard: CustomStringConvertible {
    public var description: String {
        let val = String(rawValue, radix: 16, uppercase: true)
        let rem = 16.unsafeSubtracting(val.count)
        return "0x" + String(repeating: "0" as Character, count: rem) + val
    }
}

/// An iterator over all subsets of a `Bitboard`.
public struct CarryRippler {

    private var sub: UInt64 = 0
    private let set: UInt64
    private var isFirst: Bool = true

    /// Returns whether `self` is empty.
    public var isEmpty: Bool {
        return !self.isFirst && self.sub == 0
    }

    /// Creates an instance for a full bitboard.
    public init() {
        self.init(.full)
    }

    /// Creates an instance for the given bits.
    public init(_ bits: Bitboard) {
        self.set = bits.rawValue
    }
}

extension CarryRippler: IteratorProtocol, Sequence {
    public mutating func next() -> Optional<Bitboard> {
        guard !self.isEmpty else {
            return nil
        }
        self.isFirst = false
        let sub = self.sub
        self.sub = self.set & (self.sub &- self.set)
        return Bitboard(sub)
    }
}
