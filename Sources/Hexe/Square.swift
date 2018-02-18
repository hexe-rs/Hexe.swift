//
//  Square.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec

/// A chess board square.
public enum Square: UInt8 {
    /// A1 square.
    case a1

    /// B1 square.
    case b1

    /// C1 square.
    case c1

    /// D1 square.
    case d1

    /// E1 square.
    case e1

    /// F1 square.
    case f1

    /// G1 square.
    case g1

    /// H1 square.
    case h1

    /// A2 square.
    case a2

    /// B2 square.
    case b2

    /// C2 square.
    case c2

    /// D2 square.
    case d2

    /// E2 square.
    case e2

    /// F2 square.
    case f2

    /// G2 square.
    case g2

    /// H2 square.
    case h2

    /// A3 square.
    case a3

    /// B3 square.
    case b3

    /// C3 square.
    case c3

    /// D3 square.
    case d3

    /// E3 square.
    case e3

    /// F3 square.
    case f3

    /// G3 square.
    case g3

    /// H3 square.
    case h3

    /// A4 square.
    case a4

    /// B4 square.
    case b4

    /// C4 square.
    case c4

    /// D4 square.
    case d4

    /// E4 square.
    case e4

    /// F4 square.
    case f4

    /// G4 square.
    case g4

    /// H4 square.
    case h4

    /// A5 square.
    case a5

    /// B5 square.
    case b5

    /// C5 square.
    case c5

    /// D5 square.
    case d5

    /// E5 square.
    case e5

    /// F5 square.
    case f5

    /// G5 square.
    case g5

    /// H5 square.
    case h5

    /// A6 square.
    case a6

    /// B6 square.
    case b6

    /// C6 square.
    case c6

    /// D6 square.
    case d6

    /// E6 square.
    case e6

    /// F6 square.
    case f6

    /// G6 square.
    case g6

    /// H6 square.
    case h6

    /// A7 square.
    case a7

    /// B7 square.
    case b7

    /// C7 square.
    case c7

    /// D7 square.
    case d7

    /// E7 square.
    case e7

    /// F7 square.
    case f7

    /// G7 square.
    case g7

    /// H7 square.
    case h7

    /// A8 square.
    case a8

    /// B8 square.
    case b8

    /// C8 square.
    case c8

    /// D8 square.
    case d8

    /// E8 square.
    case e8

    /// F8 square.
    case f8

    /// G8 square.
    case g8

    /// H8 square.
    case h8
}

let fileBits: UInt8 = 7
let rankBits: UInt8 = fileBits << rankShift
let rankShift: UInt = 3

extension Square {
    /// Combines the file of `self` with the rank of `other`.
    public func combine(with other: Square) -> Square {
        let file = fileBits & self.rawValue
        let rank = rankBits & other.rawValue
        return unsafeBitCast(file | rank, to: Square.self)
    }

    /// Returns the Chebyshev distance between `self` and `other`.
    public func distance(to other: Square) -> UInt {
        return UInt(bitPattern: hexe_square_distance(self.rawValue, other.rawValue))
    }

    /// Returns the Manhattan distance between `self` and `other`.
    public func manDistance(to other: Square) -> UInt {
        return UInt(bitPattern: hexe_square_man_distance(self.rawValue, other.rawValue))
    }

    /// Returns the Chebyshev distance between `self` and the center of the board.
    public func centerDistance() -> UInt {
        return UInt(bitPattern: hexe_square_center_distance(self.rawValue))
    }

    /// Returns the Manhattan distance between `self` and the center of the board.
    public func centerManDistance() -> UInt {
        return UInt(bitPattern: hexe_square_center_man_distance(self.rawValue))
    }

    /// Returns the pawn attacks at `self` for `color`.
    public func pawnAttacks(color: Color) -> Bitboard {
        return Bitboard(hexe_pawn_attacks(self.rawValue, color.rawValue))
    }

    /// Returns all knight attacks at `self`.
    public func knightAttacks() -> Bitboard {
        return Bitboard(hexe_knight_attacks(self.rawValue))
    }

    /// Returns all king attacks at `self`.
    public func kingAttacks() -> Bitboard {
        return Bitboard(hexe_king_attacks(self.rawValue))
    }

    /// Returns all rook attacks at `self`.
    public func rookAttacks(_ occupied: Bitboard) -> Bitboard {
        return Bitboard(hexe_rook_attacks(self.rawValue, occupied.rawValue))
    }

    /// Returns all bishop attacks at `self`.
    public func bishopAttacks(_ occupied: Bitboard) -> Bitboard {
        return Bitboard(hexe_bishop_attacks(self.rawValue, occupied.rawValue))
    }

    /// Returns all queen attacks at `self`.
    public func queenAttacks(_ occupied: Bitboard) -> Bitboard {
        return Bitboard(hexe_queen_attacks(self.rawValue, occupied.rawValue))
    }
}
