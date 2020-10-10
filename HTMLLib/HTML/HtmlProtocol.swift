import Bow

public protocol HtmlProtocol {
    var render: Eval<String> { get }
}

public struct HtmlString: HtmlProtocol {
    init(_ string: String) {
        self.string = string
    }

    let string: String
    public var render: Eval<String> {
        .now(string)
    }
}
