//
//  CastleRights.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 3/6/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

private let mask: UInt8 = 0b1111

/// An individual castle right for a chess game.
public struct CastleRights: Equatable {

    private var value: UInt8

    /// Creates an instance with the bit for `right` set.
    public init(right: CastleRight) {
        self.value = 1 &<< right.rawValue
    }

}

extension CastleRights: RawRepresentable {
    public var rawValue: UInt8 {
        return self.value
    }

    public init?(rawValue: UInt8) {
        guard rawValue <= mask else {
            return nil
        }
        self.value = rawValue
    }
}

/// An individual castle right for a chess game.
public enum CastleRight: UInt8 {
    /** White kingside:  E1 to G1. */ case whiteKingside
    /** White queenside: E1 to C1. */ case whiteQueenside
    /** Black kingside:  E8 to G8. */ case blackKingside
    /** Black queenside: E8 to C8. */ case blackQueenside
}
