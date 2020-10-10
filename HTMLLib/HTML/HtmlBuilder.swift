import Foundation

@_functionBuilder
public struct HtmlBuilder {
    public static func buildExpression(_ html: [Html]) -> Html {
        AnyHtml(html)
    }

    public static func buildExpression(_ html: Html) -> Html {
        html
    }

    public static func buildExpression(_ html: AnyHtml) -> Html {
        html
    }

    public static func buildBlock(_ html: Html...) -> Html {
        AnyHtml(html)
    }
}
