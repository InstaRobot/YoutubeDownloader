//
//  AddRow.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class AddRow: NSView {
  var onPress: (() -> Void)?

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    let button = NSButton(
      image: NSImage(named: NSImage.Name("plus"))!,
      target: self,
      action: #selector(onButtonPress)
    )
    
    button.isBordered = false
    
    addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: centerXAnchor),
      button.centerYAnchor.constraint(equalTo: centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  @objc func onButtonPress() {
    self.onPress?()
  }
  
}
