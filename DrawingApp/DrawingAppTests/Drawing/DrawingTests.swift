//
//  DrawingTests.swift
//  DrawingAppTests
//
//  Created by 강호성 on 11/5/23.
//

import XCTest
@testable import DrawingApp

final class DrawingTests: XCTestCase {

    var useCase: DrawingUseCase!

    override func setUp() {
        super.setUp()
        useCase = DrawingUseCaseImpl()
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func test_드로잉_시작_랜덤_색상이_지정되는지() {
        useCase.startDrawing(at: CGPoint.zero)

        XCTAssertNotNil(useCase.readCurrentColor())
    }

    func test_드로잉_시작_랜덤_색상과_시작_좌표가_일치하는지() {
        let startingPoint = CGPoint(x: 100, y: 100)

        useCase.startDrawing(at: startingPoint)

        XCTAssertEqual(useCase.readCurrentCoordinates().count, 1)
        XCTAssertEqual(useCase.readCurrentCoordinates().first, startingPoint)
    }

    func test_드로잉_다음_좌표가_일치하는지() {
        let startPoint = CGPoint(x: 100, y: 100)
        let nextPoint = CGPoint(x: 150, y: 150)

        useCase.startDrawing(at: startPoint)
        useCase.continueDrawing(to: nextPoint)

        XCTAssertEqual(useCase.readCurrentCoordinates(), [startPoint, nextPoint])
    }

    func test_드로잉_끝났을_경우_값이_저장_이후에_초기화되는지() {
        let startPoint = CGPoint(x: 100, y: 100)
        let endPoint = CGPoint(x: 150, y: 150)

        useCase.startDrawing(at: startPoint)
        useCase.continueDrawing(to: endPoint)
        useCase.endDrawing()

        XCTAssertEqual(useCase.readDrawings().count, 1)
        XCTAssertEqual(useCase.readDrawings().first?.coordinates, [startPoint, endPoint])
        XCTAssertNil(useCase.readCurrentColor())
        XCTAssertEqual(useCase.readCurrentCoordinates(), [])
    }
}
