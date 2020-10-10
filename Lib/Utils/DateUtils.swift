import Foundation

extension Date {
    public init(day: UInt, month: UInt, year: UInt) {
        var dateComponents = DateComponents()
        dateComponents.year = Int(year)
        dateComponents.month = Int(month)
        dateComponents.day = Int(day)
        self = Calendar.current.date(from: dateComponents)!
    }
}
