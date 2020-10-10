import Path
import HTML
import Site

let outputFolder = try! (Path.cwd/"build").mkdir()

let renderedSite = site.render.value()

try! renderedSite.write(to: outputFolder/"index.html")

print("Done")
