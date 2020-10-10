import Foundation
import HTML

public typealias WithReferences<T, References> = (References) -> T

public struct Page {
    public init(title: HtmlProtocol, abstract: HtmlProtocol, @SectionsBuilder sections: () -> [Section]) {
        self.title = title
        self.abstract = abstract
        self.sections = sections()
    }

    let title: HtmlProtocol
    let abstract: HtmlProtocol
    let sections: [Section]
}
