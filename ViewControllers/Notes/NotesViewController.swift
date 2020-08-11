//
//  NotesViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 29.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import DWAnimatedLabel
import WCLShineButton
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
        textView.font = UIFont(name: "Chalkduster", size: 20)
        textView.tintColor = .lightGray
        textView.textColor = .lightGray
        textView.textAlignment = .justified
        textView.layer.cornerRadius = 25
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.tintColor = .lightGray
        textView.backgroundColor = .clear
        textView.delegate = self
        return textView
    }()
    
    lazy var notesTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notes"
        label.font = UIFont(name: "Chalkduster", size: 60)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.animationType = .fade
        return label
    }()
    
    lazy var inputNotesButton: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .white
        param.smallShineColor = .white
        param.shineCount = 0
        param.shineSize = 0
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 85, height: 85), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "leafIcon.png")!)
        button.color = .lightGray
        button.fillColor = .lightGray
        button.addTarget(self, action: #selector(inputNotes), for: .touchUpInside)
        return button
    }()
    
    lazy var voiceInputTextNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "voiceIcon.png"), for: .normal)
        button.backgroundColor = .clear
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
        notesTitleLabel.startAnimation(duration: 7, .none)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.appearVC), userInfo: nil, repeats: false)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsTextView
    func createConstraintsNotesTextView() {
        notesTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        notesTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        notesTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    //MARK: ConstraintsLabel
    func createConstraintsNotesTitleLabel() {
        notesTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notesTitleLabel.bottomAnchor.constraint(equalTo: notesTextView.topAnchor, constant: -15).isActive = true
    }
    
    //MARK: ConstraintsButton
    func createConstraintsInputNotesButton() {
        inputNotesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputNotesButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 10).isActive = true
        inputNotesButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        inputNotesButton.heightAnchor.constraint(equalToConstant: 85).isActive = true
     }
    
    func createConstraintsVoiceInputTextNotesButton() {
        voiceInputTextNotesButton.leadingAnchor.constraint(equalTo: notesTitleLabel.trailingAnchor, constant: 3).isActive = true
        voiceInputTextNotesButton.bottomAnchor.constraint(equalTo: notesTextView.topAnchor, constant: -31).isActive = true
        voiceInputTextNotesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        voiceInputTextNotesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if notesTextView.text == "What have you decided?" {
            notesTextView.font = UIFont(name: "Chalkduster", size: 20)
            notesTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if notesTextView.text == "" {
            notesTextView.text = "What have you decided?"
        }
    }
    
    func addAnimationInputNotesButton() {
         inputNotesButton.params.enableFlashing = true
         inputNotesButton.params.animDuration = 1
         inputNotesButton.params.shineCount = 10
         inputNotesButton.params.shineSize = 10
         inputNotesButton.fillColor = UIColor(rgb: (60,179,113))
     }
    
    //MARK: @objc
    @objc func inputNotes() {
        if notesTextView.text == "What have you decided?" || notesTextView.text == "" {
            notesTextView.attentionTextViewNVC()
            voiceInputTextNotesButton.attentionButtonNVC()
        } else {
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.transitionDelayTimerViewController), userInfo: nil, repeats: false)
            
        }
    }
    
    @objc func transitionDelayTimerViewController() {
        self.dismissMe(animated: false)
    }
    
    @objc func voiceInputTextNotes() {
        voiceOverlayNotesVC.start(on: self, textHandler: { text, final, _ in
            if final {
            
            } else {
                self.notesTextView.text = text
            }
        }, errorHandler: { error in
            
        })
    }
    
    @objc func appearVC() {
        notesTextView.attentionTextViewNVC()
        voiceInputTextNotesButton.attentionButtonNVC()
    }
}
//MARK: Extension
extension NotesViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text == "What have you decided?" || textView.text == "" else {
            addAnimationInputNotesButton()
            return
        }
    }
}

extension NotesViewController: VoiceOverlayDelegate {
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
}

extension UITextView {
    func attentionTextViewNVC() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.02
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 2
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.02
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}

extension UIButton {
    func attentionButtonNVC() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.1
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 2
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.1
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}


