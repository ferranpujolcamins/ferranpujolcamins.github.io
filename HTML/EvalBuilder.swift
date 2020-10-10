import Bow

@_functionBuilder
public struct EvalBuilder {
    public static func buildExpression<A>(_ a: A) -> Eval<A> {
        .now(a)
    }

    public static func buildExpression<I: Default, A>(_ f: @escaping (I) -> A) -> Eval<A> {
        .later({ f(I()) })
    }

    public static func buildExpression<A>(_ eval: Eval<A>) -> Eval<A> {
        eval
    }

    public static func buildBlock<A>(_ d: Eval<A>...) -> [Eval<A>] {
        d
    }
}
