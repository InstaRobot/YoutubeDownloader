//
//  MainViewController.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

final class DownloadManager {
  var count = 0
}

final class MainViewController: NSViewController {

  private let stackView = NSStackView()
  private let scrollView = NSScrollView()
  private let downloadManager = DownloadManager()
  
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
    
    var views: NSArray?
    NSNib(nibNamed: NSNib.Name("AddRow"), bundle: nil)?.instantiate(withOwner: nil, topLevelObjects: &views)
    let addRow = views!.compactMap({ $0 as? AddRow }).first!
    
    addRow.onPress = { [weak self] in
      self?.addInput()
    }
    
    addRow.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addRow.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    stackView.addArrangedSubview(addRow)
  }
  
  private func addInput() {
    let inputRow = InputRow()
    
    downloadManager.count += 1
    inputRow.numberLabel.stringValue = "\(downloadManager.count)"
    
    inputRow.translatesAutoresizingMaskIntoConstraints = false
    inputRow.setContentCompressionResistancePriority(
      NSLayoutConstraint.Priority(rawValue: 1),
      for: .horizontal
    )
    
    NSAnimationContext.runAnimationGroup({context in
      context.duration = 0.25
      context.allowsImplicitAnimation = true
      stackView.insertArrangedSubview(inputRow, at: 1)
      
      view.layoutSubtreeIfNeeded()
    }, completionHandler: nil)
  }
    
  @IBAction func onQuitButtonPress(_ sender: NSButton) {
    NSApplication.shared.terminate(nil)
  }
}

final class FlippedClipView: NSClipView {
  override var isFlipped: Bool {
    return true
  }
}
