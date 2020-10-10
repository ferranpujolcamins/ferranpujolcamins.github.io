import Bow
import HTML

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

extension TreeLabel: Html where L: Html {
    public var render: Eval<String> {
        leaf?.render ?? .now("")
    }
}
    
// TODO: this is view code:
extension Reference: HtmlComponent {
    public var content: Html {
        // TODO: I still have to call AnyHtml here
        a(href: url) { !name }
    }
}
