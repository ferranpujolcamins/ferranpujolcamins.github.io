import HTML

public protocol PostProtocol: HtmlComponent {}

extension Post: HtmlComponent {
    public var content: HtmlProtocol {
        date
        page.content
    }
}
