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
  private let scrollView = NSScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  // MARK: - Setup

  private func setup() {
    setupScrollView()
    setupStackView()
  }
  
  private func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.hasVerticalScroller = true
    scrollView.drawsBackground = false
    
    NSLayoutConstraint.activate([
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
      
      scrollView.heightAnchor.constraint(equalToConstant: 400)
    ])
    
    let clipView = FlippedClipView()
    clipView.drawsBackground = false
    
    scrollView.contentView = clipView
    clipView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      clipView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
      clipView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
      clipView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      clipView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])

    scrollView.documentView = stackView
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.leftAnchor.constraint(equalTo: clipView.leftAnchor),
      stackView.topAnchor.constraint(equalTo: clipView.topAnchor),
      stackView.rightAnchor.constraint(equalTo: clipView.rightAnchor)
    ])
  }
  
  private func setupStackView() {
    stackView.orientation = .vertical
    stackView.edgeInsets = NSEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    addRow.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addRow.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    addRow.onPress = { [weak self] in
      self?.addInput()
    }
    
    stackView.addArrangedSubview(addRow)
  }
  
  private func addInput() {
    let inputRow = InputRow()
    
    inputRow.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      inputRow.heightAnchor.constraint(equalToConstant: 50)
    ])
    
    NSAnimationContext.runAnimationGroup({context in
      context.duration = 0.25
      context.allowsImplicitAnimation = true
      stackView.insertArrangedSubview(inputRow, at: 1)
      view.layoutSubtreeIfNeeded()
    }, completionHandler: nil)
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

final class FlippedClipView: NSClipView {
  override var isFlipped: Bool {
    return true
  }
}
