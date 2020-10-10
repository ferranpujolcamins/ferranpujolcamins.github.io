import Bow

public protocol Html {
    var render: Eval<String> { get }
}

public struct AnyHtml: Html {
    public init(@HtmlBuilder _ html: () -> AnyHtml) {
        self.html = html().html
    }

    public init(_ html: [Html]) {
        self.html = html
    }

    let html: [Html]

    public var render: Eval<String> {
        html.render
    }
}

public protocol HtmlComponent: Html {
    var body: Html { get }
}

extension HtmlComponent {
    public var render: Eval<String> {
        body.render
    }
}

extension String: Html {
    public var render: Eval<String> {
        .now(self)
    }
}

extension Array: Html where Element == Html {
    public var render: Eval<String> {
        traverse { $0.render }.map { $0.joined() }^
    }
}

extension AnyHtml: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        self.init([stringLiteral])
    }
}

extension AnyHtml: ExpressibleByStringInterpolation {
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
        html.append(literal)
    }

    public mutating func appendInterpolation<H: Html>(_ i: H) {
        html.append(i)
    }

    public mutating func appendInterpolation(_ i: Html) {
        html.append(i)
    }
}
