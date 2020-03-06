import Foundation

enum Month: CustomStringConvertible {
    case jan
    case feb
    case march
    case apr
    case may
    case june
    case july
    case aug
    case sept
    case oct
    case nov
    case dec

    var description: String {
        switch self {
        case .jan:   return "Jan."
        case .feb:   return "Feb."
        case .march: return "Mar."
        case .apr:   return "Apr."
        case .may:   return "May"
        case .june:  return "June"
        case .july:  return "July"
        case .aug:   return "Aug."
        case .sept:  return "Sept."
        case .oct:   return "Oct."
        case .nov:   return "Nov."
        case .dec:   return "Dec."
        }
    }
}

enum MonthAndYear: CustomStringConvertible {
    case past(month: Month, year: Int)
    case present

    var description: String {
        switch self {
        case .past(month: let month, year: let year): return "\(month) \(year)"
        case .present: return "Present"
        }
    }
}

infix operator /

func / (_ month: Month, _ year: Int) -> MonthAndYear {
    .past(month: month, year: year)
}
