import Foundation
import Plot

struct Skill {
    let name: String
    let level: Percentage
}

struct Job {
    let startDate: MonthAndYear
    let endDate: MonthAndYear
    let company: String
    let role: String
    let description: Node<HTML.BodyContext>
}

struct Degree {
    let startYear: Int
    let endYear: Int
    let name: String
    let institution: String
}

struct Resumee {
    let skills: [Skill]
    let jobs: [Job]
    let education: [Degree]
}
