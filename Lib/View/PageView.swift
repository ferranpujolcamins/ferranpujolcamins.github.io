import HTML

extension Page: HtmlComponent {
    public var content: HtmlProtocol {
        title
        abstract
        sections.map(\.content)
    }
}
