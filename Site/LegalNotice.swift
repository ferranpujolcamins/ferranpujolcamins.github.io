import HTML

struct LegalNotice: HtmlComponent {
    var body: Html {
        div {
            a(href: "http://creativecommons.org/licenses/by-sa/4.0/"){
                img(source: "https://i.creativecommons.org/l/by-sa/4.0/88x31.png")
            }
            br()
            """
            The content of this site is licensed under a \(a(href: "http://creativecommons.org/licenses/by-sa/4.0/", "Creative Commons Attribution-ShareAlike 4.0 International License"))
            """
            br()
            """
            Based on a work at \(a(href: "https://github.com/ferranpujolcamins/ferranpujolcamins.github.io")
                                    .addAttributes(["xmlns:dct": "http://purl.org/dc/terms/"]))
            """
        }
    }
}
