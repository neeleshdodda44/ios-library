//
//  ImageUtils.swift
//  Discreet-DMLTests
//
//  Created by Neelesh on 1/31/20.
//  Copyright © 2020 DiscreetAI. All rights reserved.
//

import Foundation

public var imagesFolder = URL(fileURLWithPath: testingUtilsPath + "CoreMLClient/Dataset/train")

public func makeImagePaths() -> ([String], [String]) {
    var examples: [String] = []
    var labels: [String] = []
    for label in [ "✊", "✋", "✌️" ] {
        for fromURL in fileURLs(at: imagesFolder.appendingPathComponent(label)) {
            examples.append(fromURL.path)
            labels.append(label)
        }
    }
    
    return (examples, labels)
}

private func fileURLs(at url: URL) -> [URL] {
    return contentsOfDirectory(at: url)!
}

func contentsOfDirectory(at url: URL) -> [URL]? {
  try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
}

private func labelURL(for label: String) -> URL {
  imagesFolder.appendingPathComponent(label)
}

private func imageURL(for label: String, filename: String) -> URL {
  labelURL(for: label).appendingPathComponent(filename)
}

private func imageURL(for example: (String, String)) -> URL {
  imageURL(for: example.1, filename: example.0)
}

@discardableResult func copyIfNotExists(from: URL, to: URL) -> Bool {
    print(from.path, to.path)
    if !FileManager.default.fileExists(atPath: to.path) {
        do {
            try FileManager.default.copyItem(at: from, to: to)
            return true
        } catch {
            print("Error: \(error)")
        }
    }
    return false
}