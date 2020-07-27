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
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var planTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My plan"
        label.font = UIFont(name: "Chalkduster", size: 45)
        label.textAlignment = .center
        label.textColor = UIColor(rgb: (135,206,250))
        label.backgroundColor = .white
        label.placeHolderColor = .lightGray
        label.animationType = .wave
        return label
    }()
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = RegistrationAndDateBirthday.targetText
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var timerLabel: CountdownLabel = {
        let label = CountdownLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkduster", size: 50)
        label.textColor = .orange
        label.animationType = .Fall
        label.textAlignment = .center
        label.countdownDelegate = self
        return label
    }()
    
    lazy var lifeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = lifeTime
        label.font = UIFont(name: "Chalkduster", size: 15)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    lazy var inputNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "thinkingIcon.png"), for: .normal)
        button.backgroundColor = .clear
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
        createConstraintsTargetView()
        createConstraintsPlanTitleLabel()
        createConstraintsTargetLabel()
        createConstraintsTimerLabel()
        createConstraintsLifeTimeLabel()
        createConstraintsInputNotesButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getNowDateInSecondsForTimer()
        timerLabel.setCountDownTime(minutes: counterTime)
        timerLabel.start()
        planTitleLabel.startAnimation(duration: 150, .none)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsView
    func createConstraintsTargetView(){
        targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        targetView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    //MARK: ConstraintsLabel
    func createConstraintsPlanTitleLabel(){
        planTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planTitleLabel.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -20).isActive = true
    }
    
    func createConstraintsTargetLabel(){
        targetLabel.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 5).isActive = true
        targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        targetLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -60).isActive = true
        targetLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 140).isActive = true
    }
    
    func createConstraintsTimerLabel(){
        timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        timerLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 1).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    func createConstraintsLifeTimeLabel(){
        lifeTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
        lifeTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
        lifeTimeLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 5).isActive = true
        lifeTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsInputNotesButton(){
        inputNotesButton.leadingAnchor.constraint(equalTo: planTitleLabel.trailingAnchor, constant: 7).isActive = true
        inputNotesButton.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -26).isActive = true
        inputNotesButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        inputNotesButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func conversionDateBirthdayForLifeTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = Date()
        let calendar = Calendar.current
        let startDate = formatter.date(from: RegistrationAndDateBirthday.dateBirthday!)
        lifeTime = "Your " + String(calendar.dateComponents([.day], from: startDate!, to: date).day! + 1) + " day"
    }

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
        self.present(viewController, animated: true, completion: nil)
    }
}

extension TimerViewController: CountdownLabelDelegate {
    func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        inputNotesButton.attentionButtonTVC()
        targetView.attentionViewTVC()
    }
    
    func countdownFinished() {
        RegistrationAndDateBirthday.targetText = nil
        let viewController = NewDayViewController()
        viewController.modalPresentationStyle = .fullScreen
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
    func attentionViewTVC() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 1
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.005
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 1
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.005
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}
