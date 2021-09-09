import Foundation
import HTML

extension Date: HtmlFragment {
    public var content: HtmlProtocol {
        let dc = Calendar.current.dateComponents([.day, .month, .year], from: self)
        Html("\(dc.day!)/\(dc.month!)/\(dc.year!)" as String)
    }
}
