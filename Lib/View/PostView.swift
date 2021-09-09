import Foundation
import Prelude
import HTML
import HTMLComponents
import CSS

public protocol PostProtocol: HtmlFragment {
    var page: Page { get }
    var date: Date { get }
    var references: References? { get }
}

public protocol SitePage: HtmlPage {
    var title: String { get }
    var styles: CSS { get }
}
extension SitePage {
    public var headContent: HtmlProtocol {
        Html("")
    }

    @CSSBuilder
    public var styles: CSS {
        Select(.body) {}
    }

    public var files: Directory {
        Directory(
            // TODO: sanitise title
            name: ".",
            files: [
                File(name: title+".html", content: render.value()),
                File(name: title+".css", content: styles.string())
            ]
        )
    }
}

extension Post: SitePage {
    public var title: String {
        page.rawTitle
    }

    @HtmlBuilder
    public var bodyContent: HtmlProtocol {
        date
        page.content
        if let references = self.references {
            references
        }
    }

    @CSSBuilder
    public var styles: CSS {
        Select(.body) {
            font(.sansSerif)
        }
    }
}
