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
