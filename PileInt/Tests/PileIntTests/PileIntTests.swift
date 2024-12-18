import XCTest
@testable import PileInt

final class PileIntTests: XCTestCase {

    func testStackInitialization() {
        let pile: PileIntProtocol = PileTabInt(capacity: 5)
        XCTAssertTrue(pile.isEmpty)
        XCTAssertEqual(pile.capacity, 5)
        XCTAssertEqual(pile.count, 0)
        XCTAssertNil(pile.top)
        XCTAssertFalse(pile.isFull)
    }

    func testPush() {
        var pile: PileIntProtocol = PileTabInt(capacity: 5)
        pile.push(value: 10)
        XCTAssertFalse(pile.isEmpty)
        XCTAssertEqual(pile.capacity, 5)
        XCTAssertEqual(pile.top, 10)
        XCTAssertEqual(pile.count, 1)
        XCTAssertFalse(pile.isFull)
    }

    func testPop() {
        var pile: PileIntProtocol = PileTabInt(capacity: 5)
        pile.push(value: 10)
        let poppedValue: Int? = pile.pop()
        XCTAssertEqual(poppedValue, 10)
        XCTAssertTrue(pile.isEmpty)
        XCTAssertEqual(pile.count, 0)
    }

    func testIsFull() {
        var pile: PileIntProtocol = PileTabInt(capacity: 2)
        pile.push(value: 10)
        pile.push(value: 20)
        XCTAssertTrue(pile.isFull)
    }

    func testPileValues()
    {
        var pile: PileIntProtocol = PileTabInt(capacity: 4)
        pile.push(value: 1)
        pile.push(value: 2)
        pile.push(value: 3)
        XCTAssertEqual(pile.pop(), 3)
        XCTAssertEqual(pile.pop(), 2)
        pile.push(value: 4)
        XCTAssertEqual(pile.pop(), 4)
        XCTAssertEqual(pile.pop(), 1)
        XCTAssertEqual(pile.count, 0)
    }
}