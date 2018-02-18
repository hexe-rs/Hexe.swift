//
//  Color.swift
//  Hexe
//
//  Created by Nikolai Vazquez on 2/18/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

/// A chess color.
public enum Color: UInt8 {
    /// White chess color.
    case white
    /// Black chess color.
    case black

    /// Creates a color from the case-insensitive scalar.
    public init?(scalar: UnicodeScalar) {
        switch scalar.value | 32 {
        case ("w" as UnicodeScalar).value:
            self = .white
        case ("b" as UnicodeScalar).value:
            self = .black
        default:
            return nil
        }
    }
}
