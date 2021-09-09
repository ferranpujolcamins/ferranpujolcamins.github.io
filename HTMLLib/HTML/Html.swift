import Bow

public protocol HtmlConvertible: HtmlProtocol {
    var html: Html { get }

    var render: Eval<String> { get }
}

extension HtmlConvertible {
    var render: Eval<String> {
        html.render
    }
}

extension Html: HtmlConvertible {
    public var html: Html {
        self
    }
}

extension HtmlElement: HtmlConvertible {
    public var html: Html {
        .element(self)
    }
}

public enum Html {
    case element(HtmlElement)
    case text(String)

    public static func empty(tag: String, attributes: [String: String] = [:]) -> Self {
        .element(.empty(tag: tag, attributes: attributes))
    }

    public static func content(tag: String, attributes: [String: String] = [:], @HtmlBuilder content: () -> [Html]) -> Self {
        .element(.content(tag: tag, attributes: attributes, content: content))
    }
}

extension Html: HtmlProtocol {
    public var render: Eval<String> {
        switch self {
        case .element(let htmlElement):
            return htmlElement.render
        case .text(let text):
            return .now(text)
        }
    }
}

prefix operator !

public prefix func !(_ s: String) -> Html {
    .text(s)
}

extension Html: ExpressibleByStringLiteral {}
extension Html: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self = .text(value)
    }

//    public init(stringInterpolation: HtmlArrayStringInterpolation) {
//        self.init(stringInterpolation.html)
//    }
}

//public struct HtmlArrayStringInterpolation: StringInterpolationProtocol {
//    var html: [HtmlProtocol]
//
//    public init(literalCapacity: Int, interpolationCount: Int) {
//        html = []
//        html.reserveCapacity(2*interpolationCount + 1)
//    }
//
//    public mutating func appendLiteral(_ literal: String) {
//        html.append(HtmlString(literal))
//    }
//
//    public mutating func appendInterpolation<H: HtmlProtocol>(_ i: H) {
//        html.append(i)
//    }
//
//    public mutating func appendInterpolation(_ i: HtmlProtocol) {
//        html.append(i)
//    }
//}
