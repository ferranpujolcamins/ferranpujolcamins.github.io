import Bow
import CSS

public protocol HtmlWithStyle: HtmlProtocol {
    var content: HtmlConvertible { get }

    @CSSBuilder
    var stylesheet: CSS { get }
}

public extension HtmlWithStyle {
    var stylesheet: CSS {
        Stylesheet {
        }
    }

    var render: Eval<String> {
        content.render
    }
}

extension Html: HtmlWithStyle {
    public var content: HtmlConvertible {
        self
    }
}

public protocol HtmlComponent: HtmlWithStyle {
    @HtmlBuilder
    var fragment: [Html] { get }

    @CSSBuilder
    var style: CSS { get }
}

//public struct AnyHtmlComponent: HtmlComponent {
//    public init(fragments: [HtmlWithStyle], style: CSS) {
//        self.fragments = fragments
//        self.style = style
//    }
//
//    public let fragments: [HtmlWithStyle]
//    public let style: CSS
//}

public extension HtmlComponent {
    var content: HtmlConvertible {
        div {
            fragment
        }.addAttributes(["class": className])
    }

    var stylesheet: CSS {
        Stylesheet {
            Class(className) {
                style
                Stylesheet(fragment.map(\.stylesheet))
            }
        }
    }

    var style: CSS {
        Stylesheet {
        }
    }

    var className: String { String(describing: Self.self) }
}
