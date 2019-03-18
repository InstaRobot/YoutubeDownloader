//
//  MainViewController.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

final class MainViewController: NSViewController {

  var task: Task?
  private let stackView = NSStackView()
  private let addRow = AddRow()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  // MARK: - Setup

  func setup() {
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
      stackView.topAnchor.constraint(equalTo: view.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    stackView.wantsLayer = true
    stackView.layer?.backgroundColor = NSColor.red.cgColor
    
    addRow.onPress = { [weak stackView] in
      stackView?.addArrangedSubview(InputRow())
    }
    
    stackView.addArrangedSubview(addRow)
  }

  // MARK: - Action

  @IBAction func startButtonTouched(_ sender: NSButton) {
    if task == nil {
      start()
    } else {
      stop()
    }
  }

  func start() {
//    let worker = Worker()
//    let arguments = worker.parse(link: linkTextView.string, location: locationTextField.stringValue)
//
//    guard !arguments.isEmpty else {
//      Utils.alert(title: "Error", message: "Please check your inputs")
//      return
//    }
//
//    startButton.title = "Stop"
//    consoleTextView.string = ""
//
//    task = Task()
//    task?.delegate = self
//
//    task?.run(arguments: arguments)
  }

  func stop() {
    task?.stop()
  }
    
  @IBAction func onQuitButtonPress(_ sender: NSButton) {
    NSApplication.shared.terminate(nil)
  }
}

extension MainViewController: TaskDelegate {

  func task(task: Task, didOutput string: String) {
    let attributedString = NSAttributedString(string: "\(string)\n")
//    consoleTextView.textStorage?.append(attributedString)
  }

  func taskDidComplete(task: Task) {
    self.task = nil
//    startButton.title = "Start"
  }
}
