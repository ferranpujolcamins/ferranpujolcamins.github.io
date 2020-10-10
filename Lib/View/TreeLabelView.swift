import HTML

extension TreeLabel: HtmlProtocol where L: HtmlComponent {}
extension TreeLabel: HtmlComponent where L: HtmlComponent {
    public var content: HtmlProtocol {
        leaf?.content ?? Html("")
    }
}
