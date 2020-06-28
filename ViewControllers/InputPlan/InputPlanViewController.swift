//
//  InputPlanViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import InstantSearchVoiceOverlay

class InputPlanViewController: UIViewController {
    //MARK: Let, Var
    lazy var voiceOverlay: VoiceOverlayController = {
        let controller = VoiceOverlayController()
        controller.delegate = self
        controller.settings.autoStart = false
        controller.settings.autoStop = true
        controller.settings.autoStopTimeout = 5
        return controller
    }()
    //MARK: View
    lazy var targetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Just do it!"
        textView.font = .systemFont(ofSize: 20)
        textView.textAlignment = .justified
        textView.layer.cornerRadius = 5
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
        label.font = .systemFont(ofSize: 40)
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
    
    lazy var voiceInputTextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("V", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(voiceInputText), for: .touchUpInside)
        return button
    }()
 //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(targetTextView)
        view.addSubview(targetTitleLabel)
        view.addSubview(inputPlanButton)
        view.addSubview(voiceInputTextButton)
        createConstraintsTargetTextView()
        createConstraintsTargetTitleLabel()
        createConstraintsInputPlanButton()
        createConstraintsVoiceInputTextButton()
        
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
        targetTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        targetTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    //MARK: ConstraintsLabel
    func createConstraintsTargetTitleLabel() {
        targetTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        targetTitleLabel.bottomAnchor.constraint(equalTo: targetTextView.topAnchor, constant: -15).isActive = true
    }
    
    //MARK: ConstraintsButton
    func createConstraintsInputPlanButton() {
        inputPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputPlanButton.topAnchor.constraint(equalTo: targetTextView.bottomAnchor, constant: 20).isActive = true
        inputPlanButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        inputPlanButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
     }
    
    func createConstraintsVoiceInputTextButton() {
        voiceInputTextButton.topAnchor.constraint(equalTo: targetTextView.topAnchor, constant: 10).isActive = true
        voiceInputTextButton.leadingAnchor.constraint(equalTo: targetTextView.trailingAnchor, constant: 10).isActive = true
        voiceInputTextButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        voiceInputTextButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if targetTextView.textColor == UIColor.lightGray {
            targetTextView.text = nil
            targetTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if targetTextView.text.isEmpty {
            targetTextView.text = "Just do it!"
            targetTextView.textColor = .lightGray
        }
    }
    //MARK: @objc
    @objc func inputPlan() {
        if targetTextView.text == "Just do it!" || targetTextView.text == ""{
            RegistrationAndDateBirthday.targetText = ""
        } else {
            RegistrationAndDateBirthday.targetText = targetTextView.text
            let viewController = TimerViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func voiceInputText() {
        voiceOverlay.start(on: self, textHandler: { text, final, _ in
            if final {
                print("Final text: \(text)")
            } else {
                print("In progress: \(text)")
            }
        }, errorHandler: { error in
            
        })
    }
}
//MARK: Extension
extension InputPlanViewController: UITextViewDelegate {
    
}

extension InputPlanViewController: VoiceOverlayDelegate {
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
}
