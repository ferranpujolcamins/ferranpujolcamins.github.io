import Bow

public struct Html: HtmlProtocol {
    public init(_ string: String) {
        self.init(stringLiteral: string)
    }

    public init(_ html: HtmlProtocol) {
        self.html = [html]
    }

    public init(_ html: [HtmlProtocol]) {
        self.html = html
    }

    let html: [HtmlProtocol]

    public var render: Eval<String> {
        html.traverse { $0.render }.map { $0.joined() }^
    }
}


prefix operator !

public prefix func !(_ s: String) -> Html {
    Html(s)
}

extension Html: ExpressibleByStringLiteral {}
extension Html: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self.init([HtmlString(value)])
    }

    public init(stringInterpolation: HtmlArrayStringInterpolation) {
        self.init(stringInterpolation.html)
    }
}

public struct HtmlArrayStringInterpolation: StringInterpolationProtocol {
    var html: [HtmlProtocol]

    public init(literalCapacity: Int, interpolationCount: Int) {
        html = []
        html.reserveCapacity(2*interpolationCount + 1)
    }

    public mutating func appendLiteral(_ literal: String) {
        html.append(HtmlString(literal))
    }

    public mutating func appendInterpolation<H: HtmlProtocol>(_ i: H) {
        html.append(i)
    }

    public mutating func appendInterpolation(_ i: HtmlProtocol) {
        html.append(i)
    }
}

