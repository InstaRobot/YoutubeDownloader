//
//  Worker.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Worker {

  func parse(link: String?, location: String?) -> [String] {
    guard let link = link, let location = location,
      !link.isEmpty,
      !location.isEmpty else {
      return []
    }

    let correctLocation = correct(location: location)
    
    return ["--output", "\(correctLocation)/%(title)s.%(ext)s", link]
  }

  func correct(location: String) -> String {
    guard location.hasSuffix("/") else {
      return location
    }

    return String(location[location.startIndex..<location.endIndex])
  }
  
  private func regex(text: String, pattern: String) -> String {
    do {
      let regex = try NSRegularExpression(pattern: pattern, options: [])
      let range = NSMakeRange(0, text.count)
      let result = regex.firstMatch(in: text, options: [], range: range)
      if let result = result, let range = Range(result.range, in: text) {
        return String(text[range])
      } else {
        return ""
      }
    } catch {
      return ""
    }
  }
  
  func findPercentage(text: String) -> Int {
    // [download] 100% of 1.09MiB in 00:00
    let pattern = "\\[download] \\d*%"
    let string = regex(text: text, pattern: pattern)
    let trimmed = string
      .replacingOccurrences(of: "[download] ", with: "")
      .replacingOccurrences(of: "%", with: "")
    
    return Int(trimmed) ?? 0
  }
  
  func findName(text: String) -> String {
    // [download] Destination: /Users/khoa/Library/Containers/com.fantageek.YoutubeDownloader/Data/Downloads/Police - how to catch the thief.mp4
    guard text.starts(with: "[download] Destination:") else {
      return ""
    }
    
    let pattern = "Downloads/.*"
    let string = regex(text: text, pattern: pattern)
    let trimmed = string
      .replacingOccurrences(of: "Downloads/", with: "")
    
    return trimmed
  }
}
