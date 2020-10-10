import HTML

public struct Htmlpage: HtmlComponent {
    public init(@HtmlBuilder headContent: () -> HtmlProtocol, @HtmlBuilder bodyContent: () -> HtmlProtocol) {
        self.headContent = headContent()
        self.bodyContent = bodyContent()
    }

    public let headContent: HtmlProtocol
    public let bodyContent: HtmlProtocol

    public var content: HtmlProtocol {
        "<!DOCTYPE html>"
        head { headContent }
        body { bodyContent }
    }
}
