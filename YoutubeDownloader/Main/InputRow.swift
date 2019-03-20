//
//  InputRow.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class InputRow: NSView {

  let leftView = NSView()
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
    
    button.isBordered = false
    leftView.wantsLayer = true
    
    addSubview(leftView)
    addSubview(contentView)
    addSubview(button)
    leftView.addSubview(numberLabel)
    
    leftView.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    heightConstraint = heightAnchor.constraint(equalToConstant: 60)
    
    NSLayoutConstraint.activate([
      leftView.topAnchor.constraint(equalTo: topAnchor),
      leftView.bottomAnchor.constraint(equalTo: bottomAnchor),
      leftView.leftAnchor.constraint(equalTo: leftAnchor),
      leftView.widthAnchor.constraint(equalToConstant: 30),
      
      contentView.leftAnchor.constraint(equalTo: leftView.rightAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentView.rightAnchor.constraint(equalTo: button.leftAnchor),
      
      button.rightAnchor.constraint(equalTo: rightAnchor),
      button.centerYAnchor.constraint(equalTo: centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 30),
      
      heightConstraint,
      
      numberLabel.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
      numberLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor)
    ])
    
    toInputMode()
    setupBorder()
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  private func toInputMode()  {
    contentView.addSubview(inputTextField)
    inputTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      inputTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      inputTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      inputTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
    
    leftView.layer?.backgroundColor = Colors.input.cgColor
    
    inputTextField.placeholderString = "Enter Youtube video url"
    button.target = self
    button.action = #selector(onDownloadPress)
  }
  
  @objc func onDownloadPress() {
    let validator = Validator()
    if (!validator.validate(string: inputTextField.stringValue)) {
      return
    }

    toDownloadMode()
  }
  
  @objc func onClosePress() {
    task?.stop()
    removeFromSuperview()
  }
  
  private func toDownloadMode() {
    inputTextField.removeFromSuperview()
    button.image = NSImage(named: NSImage.Name("delete"))!
    button.action = #selector(onClosePress)
    leftView.layer?.backgroundColor = Colors.download.cgColor
    
    progressIndicator.minValue = 0
    progressIndicator.maxValue = 100
    progressIndicator.doubleValue = 0
    progressIndicator.isIndeterminate = false
  
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    progressIndicator.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(progressIndicator)
    contentView.addSubview(descriptionLabel)
    
    heightConstraint.constant = 76
    
    NSLayoutConstraint.activate([
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      
      progressIndicator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      progressIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      progressIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      
      descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      descriptionLabel.topAnchor.constraint(equalTo: progressIndicator.bottomAnchor, constant: 4)
    ])
    
    titleLabel.stringValue = "Downloading 🚀"
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
    guard string.contains("[download]") else {
      return
    }
    
    let normalizedString = string
      .replacingOccurrences(of: "[download] ", with: "")
      .replacingOccurrences(of: "\r", with: "")
      .replacingOccurrences(of: "\n", with: "")
    
    updateUI(string: normalizedString)
  }
  
  func taskDidComplete(task: Task) {
    
  }
  
  func updateUI(string: String) {
    let worker = Worker()
    
    let percentage = Double(worker.findPercentage(text: string))
    let name = worker.findName(text: string)
    
    if percentage > progressIndicator.doubleValue {
      progressIndicator.doubleValue = percentage
    }
    
    if (!name.isEmpty) {
      titleLabel.stringValue = name
    }
    
    descriptionLabel.stringValue = string
  }
  
  private func setupBorder() {
    let topLine = NSView()
    let bottomLine = NSView()
    
    topLine.wantsLayer = true
    bottomLine.wantsLayer = true
    
    topLine.layer?.backgroundColor = Colors.separator.cgColor
    bottomLine.layer?.backgroundColor = Colors.separator.cgColor
    
    topLine.translatesAutoresizingMaskIntoConstraints = false
    bottomLine.translatesAutoresizingMaskIntoConstraints = false
    addSubview(topLine)
    addSubview(bottomLine)
    
    NSLayoutConstraint.activate([
      topLine.topAnchor.constraint(equalTo: topAnchor),
      topLine.leftAnchor.constraint(equalTo: leftAnchor),
      topLine.rightAnchor.constraint(equalTo: rightAnchor),
      topLine.heightAnchor.constraint(equalToConstant: 1),
      
      bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
      bottomLine.leftAnchor.constraint(equalTo: leftAnchor),
      bottomLine.rightAnchor.constraint(equalTo: rightAnchor),
      bottomLine.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
}
