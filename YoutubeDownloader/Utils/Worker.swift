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
  
  func findPercentage(text: String) -> String {
    // [download] 100% of 1.09MiB in 00:00
    let pattern = "\\[download] \\d*%"

    do {
      let regex = try NSRegularExpression(pattern: pattern, options: [])
      let range = NSMakeRange(0, text.count)
      let result = regex.firstMatch(in: text, options: [], range: range)
      print(result)
      return ""
    } catch {
      return ""
    }
  }
}
