import Bow
import HTML

extension Reference: HtmlComponent {
    public var content: HtmlProtocol {
        a(href: url) { !name }
    }
}

extension ReferencesProtocol {
    public var content: HtmlProtocol {
        Html(references)
    }
}

extension Tree: HtmlProtocol where A: HtmlComponent {}
extension Tree: HtmlComponent where A: HtmlComponent {
    public var content: HtmlProtocol {
        // TODO: render with tree structure
        Html(foldMap { [$0] })
    }
}
