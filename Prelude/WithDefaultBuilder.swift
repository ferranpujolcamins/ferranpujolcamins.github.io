@_functionBuilder
public struct WithDefaultBuilder {
    public static func buildExpression<A>(_ a: A) -> A {
        a
    }

    public static func buildExpression<I: Default, A>(_ f: @escaping (I) -> A) -> A {
        f(I())
    }

    public static func buildBlock<A>(_ d: A...) -> [A] {
        d
    }
}
