import Bow
import HTML

extension Reference: HtmlFragment {
    public var content: HtmlProtocol {
        a(href: url) { !name }
    }
}

extension ReferencesProtocol {
    public var content: HtmlProtocol {
        Html(references)
    }
}

extension Tree: HtmlProtocol where A: HtmlFragment {}
extension Tree: HtmlFragment where A: HtmlFragment {
    public var content: HtmlProtocol {
        // TODO: render with tree structure
        Html(foldMap { [$0] })
    }
}
