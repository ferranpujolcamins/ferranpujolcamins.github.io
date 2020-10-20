import Foundation

@_functionBuilder
public struct ArrayBuilder {
    public static func buildBlock<T>(_ elements: T...) -> [T] {
        elements
    }
}
