import HTML

public struct Htmlpage: HtmlComponent {
    public init(@HtmlBuilder headContent: () -> Html, @HtmlBuilder bodyContent: () -> Html) {
        self.headContent = headContent()
        self.bodyContent = bodyContent()
    }

    public let headContent: Html
    public let bodyContent: Html

    public var content: Html {
        "<!DOCTYPE html>"
        head { headContent }
        body { bodyContent }
    }
}
