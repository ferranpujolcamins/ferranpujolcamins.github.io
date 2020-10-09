import HTMLKit

public struct Section {
    public init(title: HTML, body: HTML, @SectionsBuilder subSections: () -> [Section] = {[]}) {
        self.title = title
        self.body = body
        self.subSections = subSections()
    }

    public init(body: HTML, @SectionsBuilder subSections: () -> [Section] = {[]}) {
        self.title = nil
        self.body = body
        self.subSections = subSections()
    }

    let title: HTML?
    let body: HTML

    let subSections: [Section]
}

@_functionBuilder
public struct SectionsBuilder {
    public static func buildBlock(_ sections: Section...) -> [Section] {
        sections
    }
}
