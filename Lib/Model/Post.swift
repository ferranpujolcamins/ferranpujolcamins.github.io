import Foundation
import HTML

public struct Post {
    public init(date: Date, title: Html, abstract: Html, @SectionsBuilder sections: () -> [Lib.Section] = {[]}) {
        page = Page(title: title, abstract: abstract, sections: sections)
        self.date = date
    }

    let page: Page
    let date: Date
}

