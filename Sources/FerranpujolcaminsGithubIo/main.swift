import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct FerranpujolcaminsGithubIo: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://www.ferranpujolcamins.cat")!
    var name = "Ferran Pujol Camins"
    var description = "A description of FerranpujolcaminsGithubIo"
    var language: Language { .english }
    var imagePath: Path? { Path("Resources/profile.jpeg") }
}

let resumee = Resumee(
    skills: [
        Skill(name: "Swift", level: 100%),
        Skill(name: "iOS", level: 100%),
        Skill(name: "Objective-C", level: 100%),
        Skill(name: "Functional programming", level: 50%),
        Skill(name: "Property testing", level: 50%),
        Skill(name: "Rust", level: 50%),
        Skill(name: "C++", level: 50%),
        Skill(name: "Haskell", level: 25%),
        Skill(name: "Purescript", level: 25%),
        Skill(name: "Category theory", level: 25%),
        Skill(name: "HTML & CSS", level: 25%),
    ],
    jobs: [
        Job(startDate: .jan / 2020,
            endDate: .present,
            company: "FREENOW",
            role: "Back-end Developer",
            description: """
                I joined the release tooling team, a newly formed team with the mission to
                develop a back-end service that automates our apps release process.
                The service is based
                on Spring, Hibernate, Kotlin and Arrow.
            """
        ),
        Job(startDate: .sept / 2018,
            endDate: .dec / 2019,
            company: "FREENOW",
            role: "iOS Developer",
            description: .p(
                "The FREENOW driver app follows the",
                .a(.href("https://github.com/freenowtech/Sensor"),
                    "Sensor reactive architecture"
                ),
                """
                , based on RxSwift.
                I worked in a cross functional team developing new features and maintaining
                legacy code. I also developed new features for the Sensor library.
                """
            )
        ),
        Job(startDate: .jan / 2018,
            endDate: .june / 2019,
            company: "Clubberize",
            role: "iOS Developer",
            description: """
            The Clubberize app extensively uses location services
            including geofencing and beacons, Branch.io deep links
            and push notifications.
            """
        ),
        Job(startDate: .apr / 2016,
            endDate: .dec / 2018,
            company: "Basetis",
            role: "iOS Developer",
            description: """
            At Basetis I worked in several iOS projects for different clients.
            I also work as QA on a client's project.
            """
        ),
        Job(startDate: .apr / 2016,
            endDate: .dec / 2018,
            company: "Everis",
            role: "iOS Developer intern",
            description: .empty
        )
    ],
    education: [
        Degree(startYear: 2011,
               endYear: 2019,
               name: "Bachelor's Degree in Mathematics (Unfinished)",
               institution: "Universitat Politècnica de Catalunya"),
        Degree(startYear: 2009,
                endYear: 2010,
                name: "Bachelor's Degree in Informatics Eng. (Unfinished)",
                institution: "Universitat Politècnica de Catalunya"),
    ]
)

let resumeePage = Page(
    path: "resumee",
    content: Content(
        title: "Resumee",
        description: "",
        body: Content.Body(node: resumeeBody(for: resumee))
    )
)

// This will generate your website using the built-in Foundation theme:
try FerranpujolcaminsGithubIo().publish(
    withTheme: .ferran,
    indentation: .spaces(4),
    additionalSteps: [
        .addPage(resumeePage)
        ]
)
