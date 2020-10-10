import Foundation

@_functionBuilder
public struct HtmlBuilder {
    public static func buildExpression(_ html: [HtmlProtocol]) -> HtmlProtocol {
        Html(html)
    }

    public static func buildExpression(_ html: HtmlProtocol) -> HtmlProtocol {
        html
    }

    public static func buildExpression(_ html: Html) -> HtmlProtocol {
        html
    }

    public static func buildBlock(_ html: HtmlProtocol...) -> HtmlProtocol {
        Html(html)
    }
}
