import Bow
import HTML
import HTMLComponents

//extension Site: HtmlComponent {
//    public var content: Html {
//        Htmlpage(headContent: {
//            ""
//        }, bodyContent: {
//            legalNotice
//        })
//    }
//}

extension Site: Html {
    public var render: Eval<String> {
        posts.first!^.flatMap { post in
            post.render.flatMap { postContent in
                Htmlpage(headContent: {
                    ""
                }, bodyContent: {
                    !postContent
                    legalNotice
                }).render
            }
        }^
    }
}

extension Section: HtmlComponent {
    public var content: Html {
        title ?? AnyHtml("")
        body
        subSections.map(\.content)
    }
}

extension Page: HtmlComponent {
    public var content: Html {
        title
        abstract
        sections.map(\.content)
    }
}

extension Post: HtmlComponent {
    public var content: Html {
        AnyHtml("\(date)" as String)
        page.content
    }
}
