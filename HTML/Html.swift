import Bow

public protocol Html {
    var render: Eval<String> { get }
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

extension Array: ExpressibleByUnicodeScalarLiteral where Element == Html {
    public typealias UnicodeScalarLiteralType = String
}

extension Array: ExpressibleByExtendedGraphemeClusterLiteral where Element == Html {
    public typealias ExtendedGraphemeClusterLiteralType = String
}

extension Array: ExpressibleByStringLiteral where Element == Html {
    public init(stringLiteral: String) {
        self = [stringLiteral]
    }
}

extension Array: ExpressibleByStringInterpolation where Element == Html {
    public init(stringInterpolation: HtmlArrayStringInterpolation) {
        self = stringInterpolation.html
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

    public mutating func appendInterpolation(_ i: Html) {
        html.append(i)
    }
}
