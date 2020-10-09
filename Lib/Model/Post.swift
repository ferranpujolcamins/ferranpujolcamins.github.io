import Foundation
import HTMLKit

public struct Post {
    public init(date: Date, title: HTML, abstract: HTML, @SectionsBuilder sections: () -> [Lib.Section] = {[]}) {
        page = Page(title: title, abstract: abstract, sections: sections)
        self.date = date
    }

    let page: Page
    let date: Date
}

