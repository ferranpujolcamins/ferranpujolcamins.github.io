import HTML
import HTMLComponents

extension Site: HtmlComponent {
    public var content: Html {
        Htmlpage(headContent: {
            ""
        }, bodyContent: {
            legalNotice
        })
    }
}
