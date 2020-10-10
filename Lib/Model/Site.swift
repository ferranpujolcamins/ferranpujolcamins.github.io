import Foundation
import Bow
import BowUtils
import HTML

public struct Site {
    public init(@HtmlBuilder description: () -> Html,
                             contactInfo: ContactInfo,
                @HtmlBuilder legalNotice: () -> Html,
                             staticPages: [Page],
                             @EvalBuilder posts: () -> [Eval<Post>]) {
        self.description = description()
        self.contactInfo = contactInfo
        self.legalNotice = legalNotice()
        self.staticPages = staticPages
        self.posts = posts()
    }

    public let description: Html
    public let contactInfo: ContactInfo
    public let legalNotice: Html
    public let staticPages: [Page]
    public let posts: [Eval<Post>]
}
