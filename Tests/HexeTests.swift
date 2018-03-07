//
//  HexeTests.swift
//  HexeTests
//
//  Created by Nikolai Vazquez on 3/6/18.
//  Copyright © 2018 Nikolai Vazquez. All rights reserved.
//

import XCTest
import Hexe

class HexeTests: XCTestCase {

    func testBitboard() {
        XCTAssertTrue(Bitboard.empty.isEmpty)
        XCTAssertFalse(Bitboard.full.isEmpty)

        XCTAssertTrue(Bitboard.full.hasMultiple)
        XCTAssertFalse(Bitboard.empty.hasMultiple)
        XCTAssertFalse(Bitboard(1).hasMultiple)

        XCTAssertEqual(Bitboard.full.count, 64)
        XCTAssertEqual(Bitboard.empty.count, 0)
        XCTAssertEqual(Bitboard(0b10).count, 1)

        for s in Square.all {
            let b = Bitboard(square: s)
            let lsb = b.lsb, msb = b.msb
            XCTAssertEqual(lsb, s)
            XCTAssertEqual(msb, s)
            XCTAssertEqual(lsb, b.lsbUnchecked)
            XCTAssertEqual(msb, b.msbUnchecked)
        }
    }

    func testAllIterator() {
        func test<T: AllIterable>(type: T.Type, count: Int)
            where T: RawRepresentable,
                  T.RawValue == UInt8
        {
            let iter = type.all
            XCTAssertEqual(iter.underestimatedCount, count)
            var i = 0
            for x in iter {
                XCTAssertEqual(i, Int(x.rawValue))
                i += 1
            }
            XCTAssertEqual(i, count)
        }
        test(type: Square.self,      count: 64)
        test(type: Color.self,       count:  2)
        test(type: Piece.self,       count: 12)
        test(type: PieceKind.self,   count:  6)
        test(type: CastleRight.self, count:  4)
    }

    func testPieceMapIsEmpty() {
        let empty = PieceMap()
        XCTAssertTrue(empty.isEmpty)

        let standard = PieceMap.standard
        XCTAssertFalse(standard.isEmpty)

        empty[.h8] = .whiteRook
        XCTAssertFalse(empty.isEmpty)
    }

}
