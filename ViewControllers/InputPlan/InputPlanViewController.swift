//
//  InputPlanViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit

class InputPlanViewController: UIViewController {
    //MARK: View
    lazy var targetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Just do it!"
        textView.font = .systemFont(ofSize: 20)
        textView.textAlignment = .justified
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.backgroundColor = .clear
        textView.textColor = .lightGray
        textView.delegate = self
        return textView
    }()
    
    lazy var tasksTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Сome on more!"
        textView.font = .systemFont(ofSize: 20)
        textView.textAlignment = .justified
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.backgroundColor = .clear
        textView.textColor = .lightGray
        textView.delegate = self
        return textView
    }()
    
    lazy var targetTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Target"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var tasksTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tasks"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var inputPlanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let's go", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(inputPlan), for: .touchUpInside)
        return button
    }()
 //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(targetTextView)
        view.addSubview(tasksTextView)
        view.addSubview(targetTitleLabel)
        view.addSubview(tasksTitleLabel)
        view.addSubview(inputPlanButton)
        createConstraintsTargetTextView()
        createConstraintsTasksTextView()
        createConstraintsTargetTitleLabel()
        createConstraintsTasksTitleLabel()
        createConstraintsInputPlanButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsTextView
    func createConstraintsTargetTextView() {
        targetTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        targetTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        targetTextView.topAnchor.constraint(equalTo: targetTitleLabel.bottomAnchor, constant: 10).isActive = true
        targetTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func createConstraintsTasksTextView() {
        tasksTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        tasksTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        tasksTextView.topAnchor.constraint(equalTo: tasksTitleLabel.bottomAnchor, constant: 10).isActive = true
        tasksTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    //MARK: ConstraintsLabel
    func createConstraintsTargetTitleLabel() {
        targetTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        targetTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func createConstraintsTasksTitleLabel() {
        tasksTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        tasksTitleLabel.topAnchor.constraint(equalTo: targetTextView.bottomAnchor, constant: 40).isActive = true
    }
    
    //MARK: ConstraintsButton
    func createConstraintsInputPlanButton() {
         inputPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         inputPlanButton.topAnchor.constraint(equalTo: tasksTextView.bottomAnchor, constant: 30).isActive = true
         inputPlanButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
     }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (targetTextView.textColor == UIColor.lightGray) && (targetTextView.text == textView.text) {
            targetTextView.text = nil
            targetTextView.textColor = UIColor.black
        }
        
        if (tasksTextView.textColor == UIColor.lightGray) && (tasksTextView.text == textView.text) {
            tasksTextView.text = nil
            tasksTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if targetTextView.text.isEmpty {
            targetTextView.text = "Just do it!"
            targetTextView.textColor = .lightGray
        }
        
        if tasksTextView.text.isEmpty {
            tasksTextView.text = "Сome on more!"
            tasksTextView.textColor = .lightGray
        }
    }
    //MARK: @objc
    @objc func inputPlan() {
        print("0_0")
    }
}
//MARK: Extension
extension InputPlanViewController: UITextViewDelegate {
    
}
