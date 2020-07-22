//
//  InputPlanViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import DWAnimatedLabel
import WCLShineButton
import InstantSearchVoiceOverlay

class InputPlanViewController: UIViewController {
    //MARK: Let, Var
    lazy var voiceOverlayInputPlanVC: VoiceOverlayController = {
        let controller = VoiceOverlayController()
        controller.delegate = self
        controller.settings.autoStart = false
        controller.settings.autoStop = true
        controller.settings.autoStopTimeout = 5
        controller.settings.layout.inputScreen.titleListening = "Speak and wait 5 sec"
        controller.settings.layout.inputScreen.subtitleBulletList = ["Do not forget to wash your hands", "Plant another tree"]

        return controller
    }()
    //MARK: View
    lazy var targetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Just do it!"
        textView.font = UIFont(name: "Chalkduster", size: 20)
        textView.tintColor = .lightGray
        textView.textColor = .lightGray
        textView.textAlignment = .justified
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = .clear
        textView.delegate = self
        return textView
    }()
    
    lazy var targetTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Target"
        label.font = UIFont(name: "Chalkduster", size: 50)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .white
        label.placeHolderColor = .lightGray
        label.animationType = .wave
        return label
    }()
    
    lazy var inputPlanButton: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .white
        param.smallShineColor = .white
        param.shineCount = 0
        param.shineSize = 0
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 60, height: 60), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .heart
        button.color = .lightGray
        button.fillColor = .lightGray
//        param.enableFlashing = true
//        param.animDuration = 1
//        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 60, height: 60), params: param)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.image = .like
//        button.color = .lightGray
//        button.fillColor = UIColor(rgb: (50,205,50))
        button.addTarget(self, action: #selector(inputPlan), for: .valueChanged)
        return button
    }()
    
    lazy var voiceInputTextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
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
        targetTitleLabel.startAnimation(duration: 150, .none)
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
        inputPlanButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        inputPlanButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
     }
    
    func createConstraintsVoiceInputTextButton() {
        voiceInputTextButton.topAnchor.constraint(equalTo: targetTextView.topAnchor, constant: 5).isActive = true
        voiceInputTextButton.trailingAnchor.constraint(equalTo: targetTextView.trailingAnchor, constant: -5).isActive = true
        voiceInputTextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        voiceInputTextButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if targetTextView.textColor == UIColor.lightGray {
            targetTextView.text = nil
            targetTextView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if targetTextView.text.isEmpty {
            targetTextView.text = "Just do it!"
            targetTextView.textColor = .lightGray
        }
    }
    
    func addAnimationInputPlanButton() {
       inputPlanButton.params.enableFlashing = true
       inputPlanButton.params.animDuration = 1
       inputPlanButton.fillColor = UIColor(rgb: (50,205,50))
    }
    //MARK: @objc
    @objc func voiceInputText() {
        voiceOverlayInputPlanVC.start(on: self, textHandler: { text, final, _ in
            if final {
            
            } else {
                self.targetTextView.textColor = .black
                self.targetTextView.text = text
            }
        }, errorHandler: { error in
            
        })
    }
   
    @objc func inputPlan() {
        if targetTextView.text == "Just do it!" || targetTextView.text == "" {
            targetTextView.attention()
        } else {
            RegistrationAndDateBirthday.targetText = targetTextView.text
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.transitionDelayTimerViewController), userInfo: nil, repeats: false)
        }
    }
    
    @objc func transitionDelayTimerViewController() {
//        let viewController = TimerViewController()
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: true, completion: nil)
    }
}
//MARK: Extension
extension InputPlanViewController: UITextViewDelegate {
    
}

extension InputPlanViewController: VoiceOverlayDelegate {
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
}

extension UITextView {
    
    func attention() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.05
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 2
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.05
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}
