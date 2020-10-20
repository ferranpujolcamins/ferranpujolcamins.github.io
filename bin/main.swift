import Path
import HTML
import Site

let buildPath = Path.cwd/"build"
try buildPath.delete()
try buildPath.mkdir()

let renderedSite = site.render()

try renderedSite.writeContents(to: buildPath)
