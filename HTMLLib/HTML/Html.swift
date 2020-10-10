import Bow

public protocol Html {
    var render: Eval<String> { get }
}

public struct AnyHtml: Html {
    public init(_ string: String) {
        self.init(stringLiteral: string)
    }

    init(_ html: Html) {
        self.html = [html]
    }

    init(_ html: [Html]) {
        self.html = html
    }

    let html: [Html]

    public var render: Eval<String> {
        html.traverse { $0.render }.map { $0.joined() }^
    }
}

public struct HtmlString: Html {
    init(_ string: String) {
        self.string = string
    }

    let string: String
    public var render: Eval<String> {
        .now(string)
    }
}

//extension String: Html {
//    public var render: Eval<String> {
//        .now(self)
//    }
//}

extension AnyHtml: ExpressibleByStringLiteral {}
extension AnyHtml: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self.init([HtmlString(value)])
    }

    public init(stringInterpolation: HtmlArrayStringInterpolation) {
        self.init(stringInterpolation.html)
    }
}

public struct HtmlArrayStringInterpolation: StringInterpolationProtocol {
    var html: [Html]

    public init(literalCapacity: Int, interpolationCount: Int) {
        html = []
        html.reserveCapacity(2*interpolationCount + 1)
    }

    public mutating func appendLiteral(_ literal: String) {
        html.append(HtmlString(literal))
    }

    public mutating func appendInterpolation<H: Html>(_ i: H) {
        html.append(i)
    }

    public mutating func appendInterpolation(_ i: Html) {
        html.append(i)
    }
}
