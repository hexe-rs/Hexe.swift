//
//  Bitboard.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

/// A bitmap chess board representation.
public struct Bitboard: RawRepresentable, Equatable, Hashable {
    /// The inner raw value.
    public var rawValue: UInt64

    /// The hash value.
    public var hashValue: Int {
        return rawValue.hashValue
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
