import HTML

extension Section: HtmlFragment {
    public var content: HtmlProtocol {
        title ?? Html("")
        body
        subSections.map(\.content)
    }
}
