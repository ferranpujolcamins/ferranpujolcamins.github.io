import Foundation

public struct ContactInfo {
    public init(twitterHandle: String, githubProfile: String, email: String) {
        self.twitterHandle = twitterHandle
        self.githubProfile = githubProfile
        self.email = email
    }

    let twitterHandle: String
    let githubProfile: String
    let email: String
}
