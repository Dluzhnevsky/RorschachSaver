//
//  TestViewController.swift
//  RroschachSaverApp
//
//  Created by Dei on 09.02.2021.
//  Copyright © 2021 Dluzhnevsky, Dmitry. All rights reserved.
//

import Cocoa

final class TestViewController: NSViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView(frame: NSApplication.shared.windows.first!.frame)
        
        guard let rorschachSaverView = RorschachSaverView(frame: view.frame, isPreview: false)  else {
            return
        }
        
        rorschachSaverView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rorschachSaverView)
        
        NSLayoutConstraint.activate([
            rorschachSaverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rorschachSaverView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: rorschachSaverView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: rorschachSaverView.bottomAnchor)
        ])
    }
    
}
