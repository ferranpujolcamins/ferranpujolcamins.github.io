import HTML
import Prelude
import Bow

public struct WithReferences<T, Ref: Default> {
    public init(build: @escaping (Ref) -> T) {
        self.references = Ref()
        self._content = build(references)
    }

    let _content: T
    public let references: Ref
}

extension WithReferences: HtmlProtocol where T: HtmlProtocol {
    public var render: Eval<String> {
        _content.render
    }
}
extension WithReferences: HtmlFragment where T: HtmlFragment {
    public var content: HtmlProtocol {
        _content
    }
}
