import Foundation
import HTMLKit

public typealias WithReferences<T, References> = (References) -> T

public struct Page {
    public init(title: HTML, abstract: HTML, @SectionsBuilder sections: () -> [Section]) {
        self.title = title
        self.abstract = abstract
        self.sections = sections()
    }

    let title: HTML
    let abstract: HTML
    let sections: [Section]
}
