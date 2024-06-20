//
//  UIKitViewController.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import UIKit

class UIKitViewController: UIViewController {
    
    let button = UIButton(type: .system)
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the button
        button.setTitle("Press Me", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Set up the label
        label.text = "Hello, World!"
        label.textAlignment = .center
        
        // Add button and label to the view
        view.addSubview(button)
        view.addSubview(label)
        
        // Set up Auto Layout constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Additional view setup
        view.backgroundColor = .white
    }
    
    @objc func buttonTapped() {
        label.text = "Button was pressed!"
    }
}
