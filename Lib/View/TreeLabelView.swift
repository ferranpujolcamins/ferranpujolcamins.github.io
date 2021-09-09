import HTML

extension TreeLabel: HtmlProtocol where L: HtmlFragment {}
extension TreeLabel: HtmlFragment where L: HtmlFragment {
    public var content: HtmlProtocol {
        leaf?.content ?? Html("")
    }
}
