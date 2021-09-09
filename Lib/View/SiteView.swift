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
                    // TODO: don't create empty files
                    files: posts.flatMap { [
                        File(name: "\($0.page.rawTitle).html", content: $0.render.value()),
                        //File(name: "\($0.page.rawTitle).css", content: $0.styles.string())
                    ] }
                )
            }
        )
    }
}
