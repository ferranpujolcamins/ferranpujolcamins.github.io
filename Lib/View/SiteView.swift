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

extension Section: HtmlComponent {
    public var content: HtmlProtocol {
        title ?? Html("")
        body
        subSections.map(\.content)
    }
}

extension Page: HtmlComponent {
    public var content: HtmlProtocol {
        title
        abstract
        sections.map(\.content)
    }
}

extension Post: HtmlComponent {
    public var content: HtmlProtocol {
        Html("\(date)" as String)
        page.content
    }
}
