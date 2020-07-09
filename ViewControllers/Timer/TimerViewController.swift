//
//  TimerViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import CountdownLabel
import LTMorphingLabel

class TimerViewController: UIViewController{
    //MARK: Let, Var
    var counterTime: Double!
    var lifeTime: String!

    //MARK: View
    lazy var targetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var planTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My plan"
        label.font = .systemFont(ofSize: 55)
        label.textAlignment = .center
        return label
    }()
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = RegistrationAndDateBirthday.targetText
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .justified
        return label
    }()
    
    lazy var timerLabel: CountdownLabel = {
        let label = CountdownLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"Courier", size: 30)
        label.animationType = .Evaporate
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.delegate = self
        return label
    }()
    
    lazy var lifeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = lifeTime
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var inputNotesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("N", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getNowDateInSecondsForTimer()
        timerLabel.setCountDownTime(minutes: counterTime)
        timerLabel.start()
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsLabel
    func createConstraintsTargetView(){
        targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        targetView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func createConstraintsPlanTitleLabel(){
        planTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planTitleLabel.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -20).isActive = true
    }
    
    func createConstraintsTargetLabel(){
        targetLabel.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 5).isActive = true
        targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
        targetLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -70).isActive = true
        targetLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 140).isActive = true
    }
    
    func createConstraintsTimerLabel(){
        timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        timerLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createConstraintsLifeTimeLabel(){
        lifeTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150).isActive = true
        lifeTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
        lifeTimeLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10).isActive = true
        lifeTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    func createConstraintsInputNotesButton(){
        inputNotesButton.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 10).isActive = true
        inputNotesButton.trailingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: -10).isActive = true
        inputNotesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        inputNotesButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func conversionDateBirthdayForLifeTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = Date()
        let calendar = Calendar.current
        let startDate = formatter.date(from: RegistrationAndDateBirthday.dateBirthday!)
        lifeTime = "Your " + String(calendar.dateComponents([.day], from: startDate!, to: date).day! + 1) + " day:)"
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

extension TimerViewController:  LTMorphingLabelDelegate {
    
}
