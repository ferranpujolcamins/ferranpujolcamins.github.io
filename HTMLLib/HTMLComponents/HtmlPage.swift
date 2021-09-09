import HTML
import CSS

public protocol HtmlPage {
    var headContent: HtmlProtocol { get }
    var bodyContent: HtmlProtocol { get }
    var styles: CSS { get }
}

public extension HtmlPage {
    @CSSBuilder
    var styles: CSS {
        Select(.body) {}
    }
}

extension HtmlPage {
    @HtmlBuilder
    public var content: HtmlProtocol {
        "<!DOCTYPE html>"
        head { headContent }
        body { bodyContent }
    }
}
