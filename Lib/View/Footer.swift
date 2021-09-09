import HTML

struct Footer: HtmlFragment {
    let contactInfo: Html
    let description: Html
    let legalNotice: Html
    
    var content: HtmlProtocol {
        contactInfo
        description
        legalNotice
    }
}
