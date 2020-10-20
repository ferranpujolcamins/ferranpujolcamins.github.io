import HTML

public struct Page {
    public init(rawTitle: String, title: HtmlProtocol, abstract: HtmlProtocol, @SectionsBuilder sections: () -> [Section]) {
        self.rawTitle = rawTitle
        self.title = title
        self.abstract = abstract
        self.sections = sections()
    }

    let title: HtmlProtocol
    let rawTitle: String
    let abstract: HtmlProtocol
    let sections: [Section]
}
