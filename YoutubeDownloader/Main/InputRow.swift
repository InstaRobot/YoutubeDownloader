//
//  InputRow.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class InputRow: NSView {
  let label = Label()

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    setupBackground()
    
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
    addSubview(label)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.leftAnchor.constraint(equalTo: leftAnchor),
      
      textField.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 8),
      textField.centerYAnchor.constraint(equalTo: centerYAnchor),
      textField.rightAnchor.constraint(equalTo: button.leftAnchor, constant: -8),
      
      button.rightAnchor.constraint(equalTo: rightAnchor),
      button.centerYAnchor.constraint(equalTo: centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  private func setupBackground() {
    let box = NSBox()
    
    box.boxType = .custom
    box.alphaValue = 1
    box.borderColor = NSColor.orange
    box.borderType = .grooveBorder
    box.borderWidth = 1
    box.cornerRadius = 10
    box.fillColor = NSColor.orange
    
    addSubview(box)
    box.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      box.leftAnchor.constraint(equalTo: leftAnchor),
      box.rightAnchor.constraint(equalTo: rightAnchor),
      box.topAnchor.constraint(equalTo: topAnchor),
      box.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  @objc func onButtonPress() {
  
  }
}
