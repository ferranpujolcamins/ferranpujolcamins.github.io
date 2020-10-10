import HTML

extension Section: HtmlComponent {
    public var content: HtmlProtocol {
        title ?? Html("")
        body
        subSections.map(\.content)
    }
}
