import Bow

struct Htmlpage: Html {
    let body: Html

    var render: Eval<String> {
        [
            
            body
        ].render
    }
}
