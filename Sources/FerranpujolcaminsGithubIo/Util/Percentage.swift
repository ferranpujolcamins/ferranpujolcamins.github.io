import Foundation

struct Percentage {
    let value: Int
}

extension Percentage: CustomStringConvertible {
    var description: String {
        "\(value)%"
    }
}

postfix operator %

extension Int {
    static postfix func %(_ value: Int) -> Percentage {
        Percentage(value: value)
    }
}
