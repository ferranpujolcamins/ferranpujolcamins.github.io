import Bow

public protocol HtmlComponent: HtmlProtocol {
    @HtmlBuilder
    var content: HtmlProtocol { get }
}

extension HtmlComponent {
    public var render: Eval<String> {
        content.render
    }
}
