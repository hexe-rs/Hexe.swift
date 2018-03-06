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

    func testPieceMapIsEmpty() {
        let empty = PieceMap()
        XCTAssertTrue(empty.isEmpty)

        let standard = PieceMap.standard
        XCTAssertFalse(standard.isEmpty)

        empty[.h8] = .whiteRook
        XCTAssertFalse(empty.isEmpty)
    }

}
