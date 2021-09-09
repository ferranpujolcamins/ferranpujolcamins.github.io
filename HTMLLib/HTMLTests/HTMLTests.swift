import XCTest
import HTML
import CSS

struct Component2: HtmlComponent {
    var fragments: [HtmlFragment] {
        p { "Component2" }
    }

    var style: CSS {
        Stylesheet {
            Select(.p) {
                background(.blue)
            }
        }
    }
}

struct Component1: HtmlComponent {
    var fragments: [HtmlFragment] {
        p { "Component1" }
        Component2()
    }

    var style: CSS {
        Stylesheet {
            Select(.p) {
                background(.red)
            }
        }
    }
}

final class HTMLTests: XCTestCase {
    func test() {
        let oracle = HtmlComponent
        let html = """
                   <div class="Component1">
                       <p class="Component1">Component1</p>
                       <div class="Component2">
                           <p class="Component2">Component2</p>
                       </div>
                   </div>
                   """
        let cssOracle = """
                        .Component1 p, .Component1 .Component1 p, .Component1 p.Component1 {
                            background: red;
                        }
                        .Component2 p, .Component2 .Component2 p, .Component2 p.Component2 {
                            background: blue;
                        }
                        """
        let comp = Component1()
        print(comp.render.value())
        print(comp.stylesheet.string())
        XCTAssertEqual(comp)
        XCTAssertEqual(comp.stylesheet.string(), cssOracle)
    }
}
