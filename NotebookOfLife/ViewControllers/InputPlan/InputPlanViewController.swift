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
        controller.settings.autoStopTimeout = 2
        controller.settings.layout.inputScreen.titleListening = "Speak and wait 2 sec"
        controller.settings.layout.inputScreen.subtitleBulletList = ["Do not forget to wash your hands", "Plant another tree"]
        return controller
    }()
    //MARK: View
    lazy var backgroundPostImageView: UIImageView = {
        let background = UIImage(named: "postImage.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        return imageView
    }()
    //MARK: TextView
    lazy var targetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Let's start!\n What is our target?"
        textView.font = UIFont(name: "Chalkduster", size: 20)
        textView.tintColor = UIColor(rgb: (245,245,245))
        textView.textColor = UIColor(rgb: (245,245,245))
        textView.textAlignment = .center
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.backgroundColor = .clear
        textView.alpha = 0
        textView.delegate = self
        return textView
    }()
    //MARK: Label
    lazy var targetTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Goal"
        label.font = UIFont(name: "Chalkduster", size: 70)
        label.textColor = .white
        label.textAlignment = .center
        label.animationType = .fade
        return label
    }()
    //MARK: Button
    lazy var inputPlanButton: WCLShineButton = {
        var param = WCLShineParams()
        param.shineCount = 0
        param.shineSize = 0
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 80, height: 80), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "goalIcon.png")!)
        button.color = UIColor(rgb: (178,34,34))
        button.fillColor = UIColor(rgb: (178,34,34))
        button.alpha = 0
        button.addTarget(self, action: #selector(inputPlan), for: .valueChanged)
        return button
    }()
    
    lazy var voiceInputTextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "podcastIcon.png"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(voiceInputText), for: .touchUpInside)
        button.alpha = 0
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
        view.addSubview(backgroundPostImageView)
        view.sendSubviewToBack(backgroundPostImageView)
        createConstraintsTargetTextView()
        createConstraintsTargetTitleLabel()
        createConstraintsInputPlanButton()
        createConstraintsVoiceInputTextButton()
    }
    //MARK: DidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        targetTitleLabel.startAnimation(duration: 5, .none)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.appearVC), userInfo: nil, repeats: false)
        targetTextView.fadeInIPVC()
        inputPlanButton.fadeInIPVC()
        voiceInputTextButton.fadeInIPVC()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsTextView
    func createConstraintsTargetTextView() {
        targetTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        targetTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        targetTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        targetTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
    }
    //MARK: ConstraintsLabel
    func createConstraintsTargetTitleLabel() {
        targetTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        targetTitleLabel.bottomAnchor.constraint(equalTo: targetTextView.topAnchor,constant: 0).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsInputPlanButton() {
        inputPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputPlanButton.topAnchor.constraint(equalTo: targetTextView.bottomAnchor).isActive = true
        inputPlanButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        inputPlanButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
     }
    
    func createConstraintsVoiceInputTextButton() {
        voiceInputTextButton.leadingAnchor.constraint(equalTo: targetTitleLabel.trailingAnchor, constant: 5).isActive = true
        voiceInputTextButton.bottomAnchor.constraint(equalTo: targetTextView.topAnchor, constant: -18).isActive = true
        voiceInputTextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        voiceInputTextButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //MARK: textViewDidBeginEditing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if targetTextView.text == " Let's start!\n What is our target?"{
            targetTextView.text = ""
        }
    }
    //MARK: textViewDidEndEditing
    func textViewDidEndEditing(_ textView: UITextView) {
        if targetTextView.text == "" {
            targetTextView.text = " Let's start!\n What is our target?"
        }
    }
    //MARK: addAnimationInputPlanButton
    func addAnimationInputPlanButton() {
        inputPlanButton.params.enableFlashing = true
        inputPlanButton.params.animDuration = 1
        inputPlanButton.params.shineCount = 10
        inputPlanButton.params.shineSize = 20
    }
    //MARK: @objc
    @objc func voiceInputText() {
        voiceOverlayInputPlanVC.start(on: self, textHandler: { text, final, _ in
            if final {
            
            } else {
                self.targetTextView.text = text
            }
        }, errorHandler: { error in
            
        })
    }
   
    @objc func inputPlan() {
        if targetTextView.text == " Let's start!\n What is our target?" || targetTextView.text == "" {
            targetTextView.attentionTextViewIPVC()
            voiceInputTextButton.attentionButtonIPVC()
        } else {
            RegistrationAndDateBirthday.targetText = targetTextView.text
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.transitionDelayTimerViewController), userInfo: nil, repeats: false)
        }
    }
    
    @objc func transitionDelayTimerViewController() {
        let viewController = TimerViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .partialCurl
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func appearVC() {
        targetTextView.attentionTextViewIPVC()
        voiceInputTextButton.attentionButtonIPVC()
    }
}
//MARK: Extension
extension InputPlanViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text == " Let's start!\n What is our target?" || textView.text == "" else {
            addAnimationInputPlanButton()
            return
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 57
    }
}

extension InputPlanViewController: VoiceOverlayDelegate {
    func recording(text: String?, final: Bool?, error: Error?) {
    }
}

extension UITextView {
    func attentionTextViewIPVC() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.4
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.05
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.4
        animationTwo.repeatCount = 2
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.05
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}

extension UIButton {
    func attentionButtonIPVC() {
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
    func fadeInIPVC(duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 1.0
      })
    }
}
