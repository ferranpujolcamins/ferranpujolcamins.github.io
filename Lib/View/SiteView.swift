import Bow
import HTML
import HTMLComponents

extension Site: HtmlComponent {
    public var content: HtmlProtocol {
        Htmlpage(headContent: {
            ""
        }, bodyContent: {
            posts.map(\.content)
            legalNotice
        })
    }
}
