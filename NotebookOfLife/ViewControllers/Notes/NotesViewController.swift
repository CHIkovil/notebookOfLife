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
        controller.settings.autoStopTimeout = 2
        controller.settings.layout.inputScreen.titleListening = "Speak and wait 2 sec"
        controller.settings.layout.inputScreen.subtitleBulletList = ["I think too much and drink"]
        return controller
    }()
    //MARK: View
    lazy var backgroundSoiImageView: UIImageView = {
        let background = UIImage(named: "soiImage.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        return imageView
    }()
    //MARK: TextView
    lazy var notesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = " What have you decided?"
        textView.font = UIFont(name: "Chalkduster", size: 18)
        textView.tintColor = .black
        textView.textColor = .black
        textView.textAlignment = .center
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.backgroundColor = .clear
        textView.alpha = 0
        textView.delegate = self
        return textView
    }()
    //MARK: Label
    lazy var notesTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notes"
        label.font = UIFont(name: "Chalkduster", size: 75)
        label.textColor = .white
        label.textAlignment = .center
        label.animationType = .fade
        return label
    }()
    //MARK: Button
    lazy var inputNotesButton: WCLShineButton = {
        var param = WCLShineParams()
        param.shineCount = 0
        param.shineSize = 0
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 80, height: 80), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "dropIcon.png")!)
        button.color = #colorLiteral(red: 0.5034754276, green: 0.8359741569, blue: 1, alpha: 1)
        button.fillColor = #colorLiteral(red: 0.5034754276, green: 0.8359741569, blue: 1, alpha: 1)
        button.alpha = 0
        button.addTarget(self, action: #selector(inputNotes), for: .touchUpInside)
        return button
    }()
    
    lazy var voiceInputTextNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "podcastIcon.png"), for: .normal)
        button.backgroundColor = .clear
        button.alpha = 0
        button.addTarget(self, action: #selector(voiceInputTextNotes), for: .touchUpInside)
        return button
    }()
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(notesTextView)
        view.addSubview(notesTitleLabel)
        view.addSubview(inputNotesButton)
        view.addSubview(voiceInputTextNotesButton)
        view.addSubview(backgroundSoiImageView)
        view.sendSubviewToBack(backgroundSoiImageView)
        createConstraintsNotesTextView()
        createConstraintsNotesTitleLabel()
        createConstraintsInputNotesButton()
        createConstraintsVoiceInputTextNotesButton()
    }
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        notesTitleLabel.startAnimation(duration: 5, .none)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.appearVC), userInfo: nil, repeats: false)
        notesTextView.fadeInNVC()
        inputNotesButton.fadeInNVC()
        voiceInputTextNotesButton.fadeInNVC()
    }
    //MARK: touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsTextView
    func createConstraintsNotesTextView() {
        notesTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        notesTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 35).isActive = true
        notesTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
    }
    //MARK: ConstraintsLabel
    func createConstraintsNotesTitleLabel() {
        notesTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notesTitleLabel.bottomAnchor.constraint(equalTo: notesTextView.topAnchor, constant: -15).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsInputNotesButton() {
        inputNotesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputNotesButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor,constant: 10).isActive = true
        inputNotesButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        inputNotesButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
     }
    
    func createConstraintsVoiceInputTextNotesButton() {
        voiceInputTextNotesButton.leadingAnchor.constraint(equalTo: notesTitleLabel.trailingAnchor, constant: 10).isActive = true
        voiceInputTextNotesButton.bottomAnchor.constraint(equalTo: notesTextView.topAnchor, constant: -35).isActive = true
        voiceInputTextNotesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        voiceInputTextNotesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //MARK: textViewDidBeginEditing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if notesTextView.text == " What have you decided?" {
            notesTextView.text = ""
        }
    }
    //MARK: textViewDidEndEditing
    func textViewDidEndEditing(_ textView: UITextView) {
        if notesTextView.text == "" {
            notesTextView.text = " What have you decided?"
        }
    }
    //MARK: addAnimationInputNotesButton
    func addAnimationInputNotesButton() {
         inputNotesButton.params.enableFlashing = true
         inputNotesButton.params.animDuration = 1
         inputNotesButton.params.shineCount = 10
         inputNotesButton.params.shineSize = 20
     }
    //MARK: @objc
    @objc func inputNotes() {
        if notesTextView.text == " What have you decided?" || notesTextView.text == "" {
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
        guard textView.text == " What have you decided?" || textView.text == "" else {
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
        animationOne.duration = 0.4
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.02
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.4
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
        animationOne.duration = 0.4
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.1
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.4
        animationTwo.repeatCount = 2
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.1
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}

extension UIView {
    func fadeInNVC(duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 1.0
      })
    }
}
