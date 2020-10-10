import Bow

struct Htmlpage: Html {
    let headContent: Html
    let bodyContent: Html

    var render: Eval<String> {
        AnyHtml {
            "<!DOCTYPE html>"
            head {
                headContent
            }
            body {
                bodyContent
            }
        }.render
    }
}
