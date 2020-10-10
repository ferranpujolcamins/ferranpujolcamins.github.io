import HTML

public struct Section {
    public init(title: Html, body: Html, @SectionsBuilder subSections: () -> [Section] = {[]}) {
        self.title = title
        self.body = body
        self.subSections = subSections()
    }

    public init(body: Html, @SectionsBuilder subSections: () -> [Section] = {[]}) {
        self.title = nil
        self.body = body
        self.subSections = subSections()
    }

    let title: Html?
    let body: Html

    let subSections: [Section]
}

@_functionBuilder
public struct SectionsBuilder {
    public static func buildBlock(_ sections: Section...) -> [Section] {
        sections
    }
}
