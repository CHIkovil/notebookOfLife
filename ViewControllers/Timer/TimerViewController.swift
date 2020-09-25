//
//  TimerViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import CountdownLabel
import DWAnimatedLabel

class TimerViewController: UIViewController {
    //MARK: Let, Var
    var counterTime: Double!
    var lifeTime: String!
    //MARK: View
    lazy var targetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()
    //MARK: View
    lazy var backgroundSoilImageView: UIImageView = {
        let background = UIImage(named: "soilImage.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        return imageView
    }()
    //MARK: Label
    lazy var planTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My plan"
        label.font = UIFont(name: "Chalkduster", size: 60)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.5034754276, green: 0.8359741569, blue: 1, alpha: 1)
        label.backgroundColor = .white
        label.placeHolderColor = .lightGray
        label.animationType = .wave
        label.alpha = 0
        return label
    }()
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = RegistrationAndDateBirthday.targetText
        label.font = UIFont(name: "Chalkduster", size: 26)
        label.textColor = UIColor(rgb: (245,245,245))
        label.textAlignment = .justified
        label.alpha = 0
        return label
    }()
    
    lazy var timerLabel: CountdownLabel = {
        let label = CountdownLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkduster", size: 40)
        label.textColor = UIColor(rgb: (255,127,80))
        label.animationType = .Fall
        label.textAlignment = .center
        label.alpha = 0
        label.countdownDelegate = self
        return label
    }()
    
    lazy var lifeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = lifeTime
        label.font = UIFont(name: "Chalkduster", size: 15)
        label.textColor = UIColor(rgb: (245,245,245))
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.clear.cgColor
        label.alpha = 0
        return label
    }()
    //MARK: Button
    lazy var inputNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "watering-canIcon.png"), for: .normal)
        button.backgroundColor = .clear
        button.alpha = 0
        button.addTarget(self, action: #selector(addNotes), for: .touchUpInside)
        return button
    }()
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        conversionDateBirthdayForLifeTimeLabel()
        view.addSubview(targetView)
        view.addSubview(planTitleLabel)
        view.addSubview(targetLabel)
        view.addSubview(timerLabel)
        view.addSubview(lifeTimeLabel)
        view.addSubview(inputNotesButton)
        view.addSubview(backgroundSoilImageView)
        view.sendSubviewToBack(backgroundSoilImageView)
        createConstraintsTargetView()
        createConstraintsPlanTitleLabel()
        createConstraintsTargetLabel()
        createConstraintsTimerLabel()
        createConstraintsLifeTimeLabel()
        createConstraintsInputNotesButton()
    }
    //MARK:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getNowDateInSecondsForTimer()
        timerLabel.setCountDownTime(minutes: counterTime)
        timerLabel.start()
        planTitleLabel.startAnimation(duration: 300, .none)
        targetView.fadeInTVC()
        planTitleLabel.fadeInTVC()
        targetLabel.fadeInTVC()
        timerLabel.fadeInTVC()
        lifeTimeLabel.fadeInTVC()
        inputNotesButton.fadeInTVC()
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsView
    func createConstraintsTargetView(){
        targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        targetView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    //MARK: ConstraintsLabel
    func createConstraintsPlanTitleLabel(){
        planTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planTitleLabel.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -25).isActive = true
    }
    
    func createConstraintsTargetLabel(){
        targetLabel.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 10).isActive = true
        targetLabel.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: 20).isActive = true
        targetLabel.trailingAnchor.constraint(lessThanOrEqualTo: targetView.trailingAnchor, constant: -20).isActive = true
        targetLabel.bottomAnchor.constraint(lessThanOrEqualTo: lifeTimeLabel.topAnchor, constant: -10).isActive = true
    }
    
    func createConstraintsTimerLabel(){
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:  -20).isActive = true
        timerLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -45).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    func createConstraintsLifeTimeLabel(){
        lifeTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
        lifeTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
        lifeTimeLabel.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -5).isActive = true
        lifeTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsInputNotesButton(){
        inputNotesButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 15).isActive = true
        inputNotesButton.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -15).isActive = true
        inputNotesButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        inputNotesButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    //MARK: conversionDateBirthdayForLifeTimeLabel
    func conversionDateBirthdayForLifeTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = Date()
        let calendar = Calendar.current
        let startDate = formatter.date(from: RegistrationAndDateBirthday.dateBirthday!)
        lifeTime = "Your " + String(calendar.dateComponents([.day], from: startDate!, to: date).day! + 1) + " day"
    }
    //MARK: getNowDateInSecondsForTimer
    func getNowDateInSecondsForTimer() {
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        counterTime = Double(86400 - (hours * 3600 + minutes * 60 + seconds))
    }
    
    //MARK: @objc
    @objc func addNotes() {
        let viewController = NotesViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .partialCurl
        self.present(viewController, animated: true, completion: nil)
    }
}
//MARK: Extension
extension TimerViewController: CountdownLabelDelegate {
    func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        inputNotesButton.attentionButtonTVC()
        targetView.attentionViewTVCА()
    }
    
    func countdownFinished() {
        RegistrationAndDateBirthday.targetText = nil
        let viewController = NewDayViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .partialCurl
        self.present(viewController, animated: true, completion: nil)
    }
}

extension UIButton {
    func attentionButtonTVC() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 1
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.1
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 1
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.1
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}

extension UIView {
    func attentionViewTVCА() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 1
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.02
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 1
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.02
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}

extension UIView {
    func fadeInTVC(duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 1.0
      })
    }
}
