public struct Deferred<A> {
    init(_ a: A) {
        get = { a }
    }
    init<I: Default>(_ f: @escaping (I) -> A) {
        get = { f(I()) }
    }
    let get: () -> A
}

@_functionBuilder
public struct DeferredBuilder {
    public static func buildExpression<A>(_ a: A) -> Deferred<A> {
        Deferred(a)
    }

    public static func buildExpression<I: Default, A>(_ f: @escaping (I) -> A) -> Deferred<A> {
        Deferred(f)
    }

    public static func buildExpression<A>(_ deferred: Deferred<A>) -> Deferred<A> {
        deferred
    }

    public static func buildBlock<A>(_ d: Deferred<A>...) -> [Deferred<A>] {
        d
    }
}
