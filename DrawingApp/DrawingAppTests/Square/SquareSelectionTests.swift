//
//  SquareSelectionTests.swift
//  DrawingAppTests
//
//  Created by 강호성 on 11/5/23.
//

import XCTest
@testable import DrawingApp

final class SquareSelectionTests: XCTestCase {

    var useCase: SquareSelectionUseCase!

    override func setUp() {
        super.setUp()
        useCase = SquareSelectionUseCaseImpl()
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func test_사각형_선택_테스트() {
        var square = Square(id: 1, color: .cyan, position: Position(x: 100, y: 100))
        useCase.selectSquare(&square)

        let selectedSquare = useCase.readSelectedSquare()
        
        XCTAssertTrue(square.isSelected)
        XCTAssertEqual(selectedSquare?.id, square.id)
    }

    func test_사각형_선택_해제_테스트() {
        var square = Square(id: 1, color: .cyan, position: Position(x: 100, y: 100))
        useCase.selectSquare(&square)
        useCase.deselectSquare(&square)

        let selectedSquare = useCase.readSelectedSquare()

        XCTAssertFalse(square.isSelected)
        XCTAssertNil(selectedSquare)
    }
}
