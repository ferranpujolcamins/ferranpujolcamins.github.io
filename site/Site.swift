import Foundation
import Lib
import HTMLKit

let site = Site(
    description: """
    I'm a former iOS developer, looking for a career change towards C++. I’m now studying and coding in C++ and Qt full time. I contribute to the open source projects FreeCAD (3D CAD) and Mixxx (DJ software). I also know Rust and Haskell. I'm interested into functional programming and category theory. 
    """,
    contactInfo: ContactInfo(twitterHandle: "ferranpujolca", githubProfile: "ferranpujolcamins", email: "me@ferranpujolcamins.cat"),
    legalNotice: "",//LegalNotice(),
    staticPages: [],
    posts: {
        generatingAMacOSBundleForMixxx
    }
)
