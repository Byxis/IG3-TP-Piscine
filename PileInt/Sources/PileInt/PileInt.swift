// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct PileInt {
    public static func createPile(capacity: Int) -> PileIntProtocol {
        return PileTabInt(capacity: capacity)
    }
}
