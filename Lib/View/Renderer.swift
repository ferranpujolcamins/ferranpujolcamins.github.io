import HTML

typealias StyleSheet = Void

typealias Renderer<T> = (T) -> ([Html], [StyleSheet])



struct Existential<R> {

    init(_ v: R) {
        self.init(v, { $0 })
    }

    init<A>(_ v: A, _ f: @escaping (A) -> R) {
        self.v = v
        self.f = { f($0 as! A) }
    }

    private let v: Any
    private let f: (Any) -> R
}
