//
//  YoutubeDownloaderTests.swift
//  YoutubeDownloaderTests
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import XCTest
@testable import YoutubeDownloader

class YoutubeDownloaderTests: XCTestCase {
  func testFindName() {
    let worker = Worker()
    let string = "[download] Destination: /Users/khoa/Library/Containers/com.fantageek.YoutubeDownloader/Data/Downloads/Police - how to catch the thief.mp4"
    let name = worker.findName(text: string)
    XCTAssertEqual(name, "Police - how to catch the thief.mp4")
  }
}
