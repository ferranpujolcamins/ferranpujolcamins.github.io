import Bow

@_functionBuilder
public struct TreeBuilder {
    public static func buildExpression<L>(_ value: L) -> Tree<L> {
        .pure(value)^
    }

    public static func buildExpression<L>(_ tree: Tree<L>) -> Tree<L> {
        tree
    }

    public static func buildExpression<L>(_ witness: TreeLabelBindingWitness<L>) -> Tree<L> {
        .pure(witness.label.leaf!)^
    }

    public static func buildExpression<L>(_ arg: (TreeLabelBindingWitness<L>, [Tree<L>])) -> Tree<L> {
        let (witness, trees) = arg
        return Tree(root: witness.label.leaf!, subForest: trees)
    }

    public static func buildExpression<L>(_ arg: (L, [Tree<L>])) -> Tree<L> {
        let (leaf, trees) = arg
        return Tree(root: leaf, subForest: trees)
    }

    public static func buildBlock<L>(_ subtrees: Tree<L>...) -> [Tree<L>] {
        subtrees
    }
}

infix operator <-: AdditionPrecedence
public final class TreeLabel<L> {
    public init() {
        self.leaf = nil
    }

    var leaf: L?

    func callAsFunction(_ leaf: L) -> TreeLabelBindingWitness<L> {
        self.leaf = leaf
        return .init(label: self)
    }

    func callAsFunction(_ leaf: L, @TreeBuilder _ subtrees: () -> [Tree<L>]) -> (TreeLabelBindingWitness<L>, [Tree<L>]) {
        self.leaf = leaf
        return (.init(label: self), subtrees())
    }
}

public struct TreeLabelBindingWitness<L> {
    let label: TreeLabel<L>
}
