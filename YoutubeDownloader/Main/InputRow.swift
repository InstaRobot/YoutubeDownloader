//
//  InputRow.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class InputRow: NSView {
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    let textField = NSTextField()
    let button = NSButton()
    
    addSubview(textField)
    addSubview(button)
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      textField.leftAnchor.constraint(equalTo: leftAnchor),
      textField.topAnchor.constraint(equalTo: topAnchor),
      textField.bottomAnchor.constraint(equalTo: bottomAnchor),
      textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
      
      button.rightAnchor.constraint(equalTo: rightAnchor),
      button.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
}
