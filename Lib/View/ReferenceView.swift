import HTML

extension Reference: HtmlComponent {
    public var content: HtmlProtocol {
        a(href: url) { !name }
    }
}
