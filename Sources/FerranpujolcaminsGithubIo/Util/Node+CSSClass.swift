import Plot

extension Node where Context: HTMLContext {
    static func `class`(_ cssClass: CSSClass...) -> Node {
        .class(cssClass.map { $0.description }.joined(separator: " "))
    }
}
