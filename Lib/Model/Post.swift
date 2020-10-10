import Foundation
import Prelude
import HTML

public protocol PostProtocol: HtmlComponent {}

public struct Post: PostProtocol {
    public init(date: Date, title: Html, abstract: Html, @SectionsBuilder sections: () -> [Lib.Section] = {[]}) {
        page = Page(title: title, abstract: abstract, sections: sections)
        self.date = date
    }

    let page: Page
    let date: Date
}

extension WithReferences: PostProtocol where T: PostProtocol, References: Default & ReferencesProtocol {}
