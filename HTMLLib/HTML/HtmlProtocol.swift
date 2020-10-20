import Bow

public protocol HtmlProtocol {
    // DO we really need eval here?
    var render: Eval<String> { get }
}

struct HtmlString: HtmlProtocol {
    init(_ string: String) {
        self.string = string
    }

    let string: String
    public var render: Eval<String> {
        .now(string)
    }
}
