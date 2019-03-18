//
//  InputRow.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class InputRow: NSView {

  var task: Task?
  let numberLabel = Label()
  let contentView = NSView()
  let inputTextField = NSTextField()
  let button = NSButton(image: NSImage(named: NSImage.Name("download"))!, target: nil, action: nil)
  let box = NSBox()
  
  let titleLabel = Label()
  let progressIndicator = NSProgressIndicator()
  var heightConstraint: NSLayoutConstraint!
  let descriptionLabel = Label()

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    setupBackground()
    button.isBordered = false
    
    addSubview(contentView)
    addSubview(button)
    addSubview(numberLabel)
    
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    heightConstraint = heightAnchor.constraint(equalToConstant: 60)
    
    NSLayoutConstraint.activate([
      numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      numberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      
      contentView.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 8),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentView.rightAnchor.constraint(equalTo: button.leftAnchor),
      
      button.rightAnchor.constraint(equalTo: rightAnchor),
      button.centerYAnchor.constraint(equalTo: centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 30),
      
      heightConstraint
    ])
    
    toInputMode()
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  private func setupBackground() {
    box.boxType = .custom
    box.alphaValue = 0.5
    box.borderColor = NSColor.orange
    box.borderType = .grooveBorder
    box.borderWidth = 2
    box.cornerRadius = 10
//    box.fillColor = NSColor.orange
    
    addSubview(box)
    box.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      box.leftAnchor.constraint(equalTo: leftAnchor),
      box.rightAnchor.constraint(equalTo: rightAnchor),
      box.topAnchor.constraint(equalTo: topAnchor),
      box.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func toInputMode()  {
    inputTextField.drawsBackground = true
    inputTextField.backgroundColor = NSColor.white
    
    contentView.addSubview(inputTextField)
    inputTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      inputTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      inputTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      inputTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
    
    button.target = self
    button.action = #selector(onDownloadPress)
  }
  
  @objc func onDownloadPress() {
    toDownloadMode()
  }
  
  @objc func onClosePress() {
    
  }
  
  private func toDownloadMode() {
    inputTextField.removeFromSuperview()
    button.image = NSImage(named: NSImage.Name("delete"))!
    button.action = #selector(onClosePress)
    box.borderColor = NSColor.green
    
    progressIndicator.minValue = 0
    progressIndicator.maxValue = 100
    progressIndicator.doubleValue = 0
  
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    progressIndicator.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(progressIndicator)
    contentView.addSubview(descriptionLabel)
    
    heightConstraint.constant = 100
    
    NSLayoutConstraint.activate([
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      
      progressIndicator.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      progressIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      progressIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      
      descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      descriptionLabel.topAnchor.constraint(equalTo: progressIndicator.bottomAnchor, constant: 4)
    ])
    
    start(url: inputTextField.stringValue)
  }
  
  private func start(url: String) {
    let worker = Worker()
    let arguments = worker.parse(link: url, location: Config.shared.location)
    task = Task()
    task?.delegate = self
    task?.run(arguments: arguments)
  }
}

extension InputRow: TaskDelegate {
  func task(task: Task, didOutput string: String) {
    titleLabel.stringValue = string
    
    let worker = Worker()
    
    let percentage = Double(worker.findPercentage(text: string))
    let name = worker.findName(text: string)
    
    if percentage > progressIndicator.doubleValue {
      progressIndicator.doubleValue = percentage
    }
    
    if (titleLabel.stringValue.isEmpty) {
       titleLabel.stringValue = name ?? ""
    }
    
    descriptionLabel.stringValue = string
  }
  
  func taskDidComplete(task: Task) {
    
  }
}
