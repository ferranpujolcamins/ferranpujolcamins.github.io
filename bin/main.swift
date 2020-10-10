import Path
import HTML
import Site

let outputFolder = try! (Path.cwd/"build").mkdir()

let legalNotice = site.legalNotice.render.value()

try! legalNotice.write(to: outputFolder/"index.html")

print("Done")
