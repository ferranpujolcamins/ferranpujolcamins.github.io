import Foundation
import Path

public struct File {
    public init(name: String, content: String) {
        self.name = name
        self.content = content
    }

    public let name: String
    public let content: String
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
