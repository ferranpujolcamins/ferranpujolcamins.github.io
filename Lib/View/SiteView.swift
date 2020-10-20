import Prelude

extension Site {
    public func render() -> Directory {
        Directory(
            name: ".",
            files: [],
            subdirectories: {
                Directory(
                    name: "posts",
                    // TODO: sanitise file names
                    files: posts.map { File(name: $0.page.rawTitle, content: $0.render.value()) }
                )
            }
        )
    }
}
