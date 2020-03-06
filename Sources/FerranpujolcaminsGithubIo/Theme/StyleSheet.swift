enum StyleSheet: String, CustomStringConvertible, CaseIterable {
    case meter
    case main
    case autotable

    var description: String {
        "\(rawValue).css"
    }
}
