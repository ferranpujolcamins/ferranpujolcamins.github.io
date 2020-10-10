import Foundation
import HTML

public typealias WithReferences<T, References> = (References) -> T

public struct Page {
    public init(title: Html, abstract: Html, @SectionsBuilder sections: () -> [Section]) {
        self.title = title
        self.abstract = abstract
        self.sections = sections()
    }

    let title: Html
    let abstract: Html
    let sections: [Section]
}
