//
//  FileReader.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/2/20.
//

import Foundation

struct FileReader {
    let fileContents: String?

    init(file: String) {
        do {
//            let path = Bundle.main.path(forResource: file, ofType: "txt", inDirectory: "2020")!
            let path = Bundle.main.path(forResource: file, ofType: "txt")!
            let data = try String(contentsOfFile: path, encoding: .utf8)
            self.fileContents = data
        } catch {
            self.fileContents = nil
        }
    }

    init(raw: String?) {
        self.fileContents = raw
    }

    var lines: [String] {
        if let content = fileContents {
            return content.components(separatedBy: "\n").filter { $0 != "" }
        } else {
            return []
        }
    }

    var chunksByNewline: [String] {
        let trim = CharacterSet(arrayLiteral: "\n", " ")
        if let content = fileContents {
            return content.components(separatedBy: "\n\n").map { $0.trimmingCharacters(in: trim) }
        } else {
            return []
        }
    }

    var arrayOfInts: [Int] {
        return lines.map { Int($0) ?? 0 }
    }

    var commaSeparatedInts: [Int] {
        if let line = lines.first {
            return line.components(separatedBy: ",").map { Int($0) ?? 0 }
        } else {
            return []
        }
    }

    var csv: [[String]] {
        return lines.map({ (line) in
            return line.components(separatedBy: ",")
        })
    }
}
