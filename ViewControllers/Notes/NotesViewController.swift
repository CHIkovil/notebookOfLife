//
//  NotesViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 29.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import InstantSearchVoiceOverlay

class NotesViewController: UIViewController {
    //MARK: Let, Var
    lazy var voiceOverlayNotesVC: VoiceOverlayController = {
        let controller = VoiceOverlayController()
        controller.delegate = self
        controller.settings.autoStart = false
        controller.settings.autoStop = true
        controller.settings.autoStopTimeout = 5
        controller.settings.layout.inputScreen.titleListening = "Speak and wait 5 sec"
        controller.settings.layout.inputScreen.subtitleBulletList = ["I think too much and drink"]

        return controller
    }()
    //MARK: View
    lazy var notesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "What have you decided?"
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
    
    lazy var notesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notes"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    lazy var inputNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let it rain", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(inputNotes), for: .touchUpInside)
        return button
    }()
    
    lazy var voiceInputTextNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("V", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(voiceInputTextNotes), for: .touchUpInside)
        return button
    }()
 //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(notesTextView)
        view.addSubview(notesTitleLabel)
        view.addSubview(inputNotesButton)
        view.addSubview(voiceInputTextNotesButton)
        createConstraintsNotesTextView()
        createConstraintsNotesTitleLabel()
        createConstraintsInputNotesButton()
        createConstraintsVoiceInputTextNotesButton()
        
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
    func createConstraintsNotesTextView() {
        notesTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        notesTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        notesTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    //MARK: ConstraintsLabel
    func createConstraintsNotesTitleLabel() {
        notesTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notesTitleLabel.bottomAnchor.constraint(equalTo: notesTextView.topAnchor, constant: -15).isActive = true
    }
    
    //MARK: ConstraintsButton
    func createConstraintsInputNotesButton() {
        inputNotesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputNotesButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 20).isActive = true
        inputNotesButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        inputNotesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
     }
    
    func createConstraintsVoiceInputTextNotesButton() {
        voiceInputTextNotesButton.topAnchor.constraint(equalTo: notesTextView.topAnchor, constant: 10).isActive = true
        voiceInputTextNotesButton.trailingAnchor.constraint(equalTo: notesTextView.trailingAnchor, constant: -10).isActive = true
        voiceInputTextNotesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        voiceInputTextNotesButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if notesTextView.textColor == UIColor.lightGray {
            notesTextView.text = nil
            notesTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if notesTextView.text.isEmpty {
            notesTextView.text = "What have you decided?"
            notesTextView.textColor = .lightGray
        }
    }
    //MARK: @objc
    @objc func inputNotes() {
        if notesTextView.text == "What have you decided?" || notesTextView.text == ""{
            
        } else {
            print("0_0")
        }
    }
    
    @objc func voiceInputTextNotes() {
        voiceOverlayNotesVC.start(on: self, textHandler: { text, final, _ in
            if final {
            
            } else {
                self.notesTextView.textColor = .black
                self.notesTextView.text = text
            }
        }, errorHandler: { error in
            
        })
    }
}
//MARK: Extension
extension NotesViewController: UITextViewDelegate {
    
}

extension NotesViewController: VoiceOverlayDelegate {
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
}
