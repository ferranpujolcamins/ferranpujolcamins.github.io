//public func a(href: String) -> Html {
//    a(href: href) { !href }
//}

public func a(href: String, @HtmlBuilder _ content: () -> [Html]) -> Html {
    .content(tag: "a", attributes: ["href": href], content: content)
}

public func br() -> HtmlElement {
    .empty(tag: "br")
}

public func body(@HtmlBuilder _ content: () -> [Html]) -> Html {
    .content(tag: "body", content: content)
}

public func div(attributes: [String: String] = [:], @HtmlBuilder _ content: () -> [Html]) -> HtmlElement {
    .content(tag: "div", attributes: attributes, content: content)
}

public func head(@HtmlBuilder _ content: () -> [Html]) -> Html {
    .content(tag: "head", content: content)
}

public func html(@HtmlBuilder _ content: () -> [Html]) -> Html {
    .content(tag: "html", content: content)
}

public func img(source: String, alt: String? = nil) -> Html {
    let altAttribute = alt.map { ["alt": $0] } ?? [:]
    return .empty(tag: "img",
                  attributes: ["src": source].combine(altAttribute))
}

public func p(@HtmlBuilder _ content: () -> [Html]) -> Html {
    .content(tag: "p", content: content)
}
