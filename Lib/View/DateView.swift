import Foundation
import HTML

extension Date: HtmlComponent {
    public var content: HtmlProtocol {
        let dc = Calendar.current.dateComponents([.day, .month, .year], from: self)
        Html("\(dc.day!)/\(dc.month!)/\(dc.year!)" as String)
    }
}
