import Foundation
import Prelude
import HTML

public struct Post: PostProtocol {
    public init(date: Date, rawTitle: String, abstract: Html, references: References? = nil, @SectionsBuilder sections: () -> [Lib.Section] = {[]}) {
        self.init(date: date,
                  rawTitle: rawTitle,
                  title: Html(rawTitle),
                  abstract: abstract,
                  references: references,
                  sections: sections)
    }

    public init(date: Date, rawTitle: String, title: Html, abstract: Html, references: References? = nil, @SectionsBuilder sections: () -> [Lib.Section] = {[]}) {
        page = Page(rawTitle: rawTitle, title: title, abstract: abstract, sections: sections)
        self.date = date
        self.references = references
    }

    public let page: Page
    public let date: Date
    public let references: References?
}

extension WithReferences: PostProtocol where T: PostProtocol, Ref: ReferencesProtocol {
    public var page: Page {
        _content.page
    }

    public var date: Date {
        _content.date
    }

    public var references: References? {
        _content.references
    }
}
