import Path

let outputFolder = try! (Path.cwd/"build").mkdir()

try! "Test".write(to: outputFolder/"index.html")
