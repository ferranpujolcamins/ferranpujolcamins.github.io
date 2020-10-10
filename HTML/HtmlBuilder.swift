import Foundation

@_functionBuilder
public struct HtmlBuilder {
//    public static func buildExpression<A>(_ a: A) -> Eval<A> {
//        .now(a)
//    }
//
//    public static func buildExpression<I: Default, A>(_ f: @escaping (I) -> A) -> Eval<A> {
//        .later({ f(I()) })
//    }
//
//    public static func buildExpression<H: Html>(_ html: H) -> Html {
//        html
//    }
//
//    public static func buildExpression(_ html: Html) -> Html {
//        html
//    }
//
//    public static func buildExpression(_ html: HtmlElement) -> Html {
//        html
//    }


//    public static func buildExpression(_ html: [Html]) -> Html {
//        html
//    }

    public static func buildBlock(_ html: Html...) -> [Html] {
        html
    }
}
