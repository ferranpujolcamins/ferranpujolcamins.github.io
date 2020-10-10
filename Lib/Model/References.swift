import Bow
import HTML

public protocol ReferencesProtocol: HtmlComponent {
    var references: References { get }
}

public typealias References = [Tree<Reference>]

public final class Reference {
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }

    let name: String
    let url: String
}

extension TreeLabel where L == Reference {
    public func callAsFunction(name: String, url: String) -> TreeLabelBindingWitness<Reference> {
        self(Reference(name: name, url: url))
    }

    public func callAsFunction(name: String, url: String, @TreeBuilder _ subtrees: () -> [Tree<L>]) -> (TreeLabelBindingWitness<L>, [Tree<L>]) {
        self(Reference(name: name, url: url), subtrees)
    }
}
