//
//  FileReader.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/2/20.
//

import Foundation

struct FileReader {
    let path: String

    init(file: String) {
        self.path = Bundle.main.path(forResource: file, ofType: "txt")!
    }

    var fileContents: String? {
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            return nil
        }
    }

    var lines: [String] {
        if let content = fileContents {
            return content.components(separatedBy: "\n").filter { $0 != "" }
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
