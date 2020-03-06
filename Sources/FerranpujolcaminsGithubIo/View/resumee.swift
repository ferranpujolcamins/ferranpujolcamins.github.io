import Foundation
import Plot

extension Node where Context: HTML.BodyContext {
    static func resumee(_ resumee: Resumee) -> Self {
        .div(
            .skills(resumee.skills),
            .jobs(resumee.jobs),
            .education(resumee.education)
        )
    }

    static func skills(_ skills: [Skill]) -> Self {
        .div(
            .class(.skills),
            .h1(.text("Skills")),
            .div(
                .class(.autoTable),
                .forEach(skills) { .skill($0) }
            )
        )
    }

    static func skill(_ skill: Skill) -> Self {
        .div(
            .div(.text(skill.name)),
            .div(
                .class(.meter),
                .span(.style("width: \(skill.level)"))
            )
        )
    }

    static func jobs(_ jobs: [Job]) -> Self {
        let jobsByCompany = Dictionary(grouping: jobs, by: { $0.company })
        return .div(
            .h1(.text("Jobs")),
            .forEach(jobsByCompany, { arg -> Node<HTML.BodyContext> in
                let (company, jobs) = arg
                return .div(
                    .h2(.text(company)),
                    .forEach(jobs, { .job($0) })
                )
            })
        )
    }

    static func job(_ job: Job) -> Self {
        .div(
            .div("\(job.startDate) - \(job.endDate)"),
            .div(
                .h3(.text(job.role)),
                job.description
            )
        )
    }

    static func education(_ degrees: [Degree]) -> Self {
        .div(
            .h1(.text("Education")),
            .forEach(degrees) { .degree($0) }
        )
    }

    static func degree(_ degree: Degree) -> Self {
        .div(
            .div(.style("float: left"),
                "\(degree.startYear) - \(degree.endYear)"),
            .div(
                .h3(.text(degree.name)),
                .text(degree.institution)
            )
        )
    }
}

func resumeeBody(for resumee: Resumee) -> Node<HTML.BodyContext> {
    .div(
        .resumee(resumee)
    )
}
