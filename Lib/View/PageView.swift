import HTML

extension Page: HtmlFragment {
    public var content: HtmlProtocol {
        title
        abstract
        sections.map(\.content)
    }
}
