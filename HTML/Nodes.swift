public func a(href: String) -> HtmlElement {
    a(href: href) { href }
}

public func a(href: String, @HtmlBuilder _ content: () -> AnyHtml) -> HtmlElement {
    .content(tag: "a", attributes: ["href": href], content: content)
}

public func br() -> HtmlElement {
    .empty(tag: "br")
}

public func body(@HtmlBuilder _ content: () -> AnyHtml) -> HtmlElement {
    .content(tag: "body", content: content)
}

public func div(@HtmlBuilder _ content: () -> AnyHtml) -> HtmlElement {
    .content(tag: "div", content: content)
}

public func head(@HtmlBuilder _ content: () -> AnyHtml) -> HtmlElement {
    .content(tag: "head", content: content)
}

public func html(@HtmlBuilder _ content: () -> AnyHtml) -> HtmlElement {
    .content(tag: "html", content: content)
}

public func img(source: String, alt: String? = nil) -> HtmlElement {
    let altAttribute = alt.map { ["alt": $0] } ?? [:]
    return .empty(tag: "img",
                  attributes: ["src": source].combine(altAttribute))
}
