import Foundation
import Bow
import BowUtils
import Prelude
import HTML

public struct Site {
    public init(@HtmlBuilder description: () -> HtmlProtocol,
                             contactInfo:       ContactInfo,
                @HtmlBuilder legalNotice: () -> HtmlProtocol,
                             staticPages:       [Page],
               @WithDefaultBuilder posts: () -> [Post]
    ) {
        self.description = description()
        self.contactInfo = contactInfo
        self.legalNotice = legalNotice()
        self.staticPages = staticPages
        self.posts = posts()
    }

    public let description: HtmlProtocol
    public let contactInfo: ContactInfo
    public let legalNotice: HtmlProtocol
    public let staticPages: [Page]
    public let posts: [Post]
}
