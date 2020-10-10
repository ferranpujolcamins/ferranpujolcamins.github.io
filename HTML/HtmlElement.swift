import Bow

public struct HtmlElement: Html {
    private enum TypeOfNode {
        case empty
        case content([Html])
    }

    private init(tag: String, attributes: [String : String], type: TypeOfNode) {
        self.tag = tag
        self.attributes = attributes
        self.type = type
    }

    public static func empty(tag: String, attributes: [String: String] = [:]) -> Self {
        self.init(tag: tag, attributes: attributes, type: .empty)
    }

    public static func content(tag: String, attributes: [String: String] = [:], @HtmlBuilder content: () -> [Html]) -> Self {
        self.init(tag: tag, attributes: attributes, type: .content(content()))
    }

    let tag: String
    let attributes: [String: String]
    private let type: TypeOfNode

    public var render: Eval<String> {
        let renderedAttributes: [String] = attributes.map { arg in
            let (attribute, value) = arg
            return """
            \(attribute): "\(value)"
            """
        }
        let renderedOpeningTagAndAttributes = "<\(tag) \(renderedAttributes)>"
        switch type {
        case .empty:
            return Eval.now(renderedOpeningTagAndAttributes)
        case .content(let content):
            return content.render.flatMap { renderedContent in
                return Eval.now("""
                    \(renderedOpeningTagAndAttributes)
                        \(renderedContent)
                    </\(tag)>
                    """)
            }^
        }
    }

    public func addAttributes(_ newAttributes: [String: String]) -> Self {
        .init(tag: tag, attributes: attributes.combine(newAttributes), type: type)
    }
}
