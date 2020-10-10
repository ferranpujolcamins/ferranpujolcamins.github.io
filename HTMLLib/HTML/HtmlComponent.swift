import Bow

public protocol HtmlComponent: Html {
    @HtmlBuilder
    var content: Html { get }
}

extension HtmlComponent {
    public var render: Eval<String> {
        content.render
    }
}
