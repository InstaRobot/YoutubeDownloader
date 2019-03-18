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
    textField.backgroundColor = NSColor.white
    
    let button = NSButton(
      image: NSImage(named: NSImage.Name("download"))!,
      target: self,
      action: #selector(onButtonPress)
    )
    
    button.isBordered = false
    
    addSubview(textField)
    addSubview(button)
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      textField.leftAnchor.constraint(equalTo: leftAnchor),
      textField.centerYAnchor.constraint(equalTo: centerYAnchor),
      textField.rightAnchor.constraint(equalTo: button.leftAnchor, constant: -20),
      
      button.rightAnchor.constraint(equalTo: rightAnchor),
      button.centerYAnchor.constraint(equalTo: centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  @objc func onButtonPress() {
  
  }
}
