//
//  Piece.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import hexec

/// A chess piece with a kind and color.
public enum Piece: UInt8 {
    /// White Pawn piece.
    case whitePawn

    /// Black Pawn piece.
    case blackPawn

    /// White Knight piece.
    case whiteKnight

    /// Black Knight piece.
    case blackKnight

    /// White Bishop piece.
    case whiteBishop

    /// Black Bishop piece.
    case blackBishop

    /// White Rook piece.
    case whiteRook

    /// Black Rook piece.
    case blackRook

    /// White Queen piece.
    case whiteQueen

    /// Black Queen piece.
    case blackQueen

    /// White King piece.
    case whiteKing

    /// Black King piece.
    case blackKing
}

extension Piece {
    /// Creates a new instance from `kind` and `color`.
    public init(kind: PieceKind, color: Color) {
        self = unsafeBitCast((kind.rawValue << 1) | color.rawValue, to: Piece.self)
    }

    /// Creates a color from the case-insensitive scalar.
    public init?(scalar: UnicodeScalar) {
        switch scalar {
        case "P": self = .whitePawn   case "p": self = .blackPawn
        case "N": self = .whiteKnight case "n": self = .blackKnight
        case "B": self = .whiteBishop case "b": self = .blackBishop
        case "R": self = .whiteRook   case "r": self = .blackRook
        case "Q": self = .whiteQueen  case "q": self = .blackQueen
        case "K": self = .whiteKing   case "k": self = .blackKing
        default:
            return nil
        }
    }

    /// The piece's kind.
    public var kind: PieceKind {
        get {
            return unsafeBitCast(self.rawValue >> 1, to: PieceKind.self)
        }
        set {
            self = unsafeBitCast(((self.rawValue & 1) | (newValue.rawValue << 1)), to: Piece.self)
        }
    }

    /// This piece's color.
    public var color: Color {
        get {
            return unsafeBitCast(self.rawValue & 1, to: Color.self)
        }
        set {
            self = unsafeBitCast((self.rawValue & ~1) | newValue.rawValue, to: Piece.self)
        }
    }
}

/// A chess piece kind.
public enum PieceKind: UInt8 {
    /// Pawn kind.
    case pawn

    /// Knight kind.
    case knight

    /// Bishop kind.
    case bishop

    /// Rook kind.
    case rook

    /// Queen kind.
    case queen

    /// King kind.
    case king
}
