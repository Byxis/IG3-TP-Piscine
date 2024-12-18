// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct MyUtils {
    public static func sayHello() {
        print("Hello from MyUtils!")
    }
    
    // Renvoie un nombre aléatoire entre 0 et 100
    public static var randomInt: Int {
        return Int.random(in: 0...100)
    }
}