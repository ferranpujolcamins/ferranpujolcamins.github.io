import Foundation
import HTMLKit

public struct Site {
    public init(description: HTML, contactInfo: ContactInfo, legalNotice: HTML, staticPages: [Page], @DeferredBuilder posts: () -> [Deferred<Post>]) {
        self.description = description
        self.contactInfo = contactInfo
        self.legalNotice = legalNotice
        self.staticPages = staticPages
        self.posts = posts()
    }

    let description: HTML
    let contactInfo: ContactInfo
    let legalNotice: HTML
    let staticPages: [Page]
    let posts: [Deferred<Post>]
}
