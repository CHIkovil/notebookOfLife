//
//  TimerViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    //MARK: Let, Var
    var counterTime:Int!
    var oneDayTimer = Timer()
    
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
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = RegistrationAndDateBirthday.targetText
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .justified
        return label
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0_0"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var lifeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = conversionDateBirthdayForLifeTimeLabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(targetView)
        view.addSubview(planTitleLabel)
        view.addSubview(targetLabel)
        view.addSubview(timerLabel)
        view.addSubview(lifeTimeLabel)
        createConstraintsTargetView()
        createConstraintsPlanTitleLabel()
        createConstraintsTargetLabel()
        createConstraintsTimerLabel()
        createConstraintsLifeTimeLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getNowDateInSecondsForTimer()
        startTimer()
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
        targetLabel.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: 20).isActive = true
    }
    
    func createConstraintsTimerLabel(){
        timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        timerLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createConstraintsLifeTimeLabel(){
        lifeTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        lifeTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120).isActive = true
        lifeTimeLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10).isActive = true
        lifeTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    func startTimer() {
        oneDayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func timeStringForTimerLabel(_ time:Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func conversionDateBirthdayForLifeTimeLabel() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = Date()
        let calendar = Calendar.current
        let startDate = formatter.date(from: RegistrationAndDateBirthday.dateBirthday!)
        return "Your " + String(calendar.dateComponents([.day], from: startDate!, to: date).day! + 1) + " day:)"
    }
    
    func getNowDateInSecondsForTimer() {
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        counterTime = 86400 - hours * 3600 + minutes * 60 + seconds
    }
    //MARK: @objc
    @objc func timerAction() {
        counterTime -= 1
        timerLabel.text = "\(timeStringForTimerLabel(counterTime))"
        if counterTime == 0 {
            oneDayTimer.invalidate()
        }
    }
}
//MARK: Extension
extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = "Wow"
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/3
    }
}
