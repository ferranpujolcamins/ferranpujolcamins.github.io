import Foundation
import HTML
import HTMLComponents
import CSS

public protocol PostProtocol: HtmlComponent {
    var page: Page { get }
    var date: Date { get }
    var references: References? { get }
}

public protocol SitePage: HtmlPage {}
extension SitePage {
    public var headContent: HtmlProtocol {
        Html("")
    }
}

extension Post: SitePage {
    @HtmlBuilder
    public var bodyContent: HtmlProtocol {
        date
        page.content
        if let references = self.references {
            references
        }
    }

//    @CSSBuilder
//    public var styles: CSS? {
//        <#code#>
//    }
}
