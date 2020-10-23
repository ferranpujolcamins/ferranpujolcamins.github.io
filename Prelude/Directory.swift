import Foundation
import Bow
import Path

public struct File {
    public init(name: String, content: String) {
        self.name = name
        self.content = content
    }

    public let name: String
    public let content: String
}

@_functionBuilder
struct _TreeBuilder {
    public static func buildExpression<L>(_ value: L) -> Tree<L> {
        .pure(value)^
    }

    public static func buildExpression<L>(_ tree: Tree<L>) -> Tree<L> {
        tree
    }


    public static func buildExpression<L>(_ arg: (L, [Tree<L>])) -> Tree<L> {
        let (leaf, trees) = arg
        return Tree(root: leaf, subForest: trees)
    }

    public static func buildBlock<L>(_ subtrees: Tree<L>...) -> [Tree<L>] {
        subtrees
    }
}

extension Tree {
    convenience init(root: A, @_TreeBuilder _ subForest: () -> [Tree<A>]) {
        self.init(root: root, subForest: subForest())
    }
}

public struct Directory {
    let tree: Tree<(name: String, files: [File])>

    public let name: String
    public let files: [File]
    public var subdirectories: [Directory] {
        tree.sub
    }
}

public struct Directory {
    public init(name: String, files: [File], @ArrayBuilder subdirectories: () -> [Directory] = {[]}) {
        self.name = name
        self.files = files
        self.subdirectories = subdirectories()
    }

    public let name: String
    public let files: [File]
    public let subdirectories: [Directory]

    public func writeContents(to path: Path) throws {
        let root = try (path/name).mkdir()
        for file in files {
            let filePath = root/file.name
            try file.content.write(to: filePath)
            print("Rendered \(filePath)")
        }
        for dir in subdirectories {
            try dir.writeContents(to: root)
        }
    }
}
