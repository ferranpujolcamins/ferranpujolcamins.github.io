import Foundation
import Bow
import Prelude
import HTML

public struct WithReferences<T, References> {
    public init(build: @escaping (References) -> T) {
        self.build = build
    }

    let build: (References) -> T
}

extension WithReferences: HtmlProtocol where T: HtmlComponent, References: Default & HtmlComponent {}
extension WithReferences: HtmlComponent where T: HtmlComponent, References: Default & HtmlComponent {
    public var content: HtmlProtocol {
        let references = References()
        return div {
            build(references)
            references
        }
    }
}

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
