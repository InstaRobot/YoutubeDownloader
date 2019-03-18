//
//  Validator.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import Foundation

class Validator {
  func validate(string: String) -> Bool {
    guard (string.contains("https://www.youtube.com/watch?v")) else {
      Alert.show(message: "Incorrect youtube url!")
      return false
    }
    
    return true
  }
}
