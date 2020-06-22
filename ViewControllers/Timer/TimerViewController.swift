//
//  TimerViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    //MARK: View
    lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.separatorColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var planTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My plan"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "    Wow, this my target."
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "24:00:00"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var lifeTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6123d."
        label.font = .systemFont(ofSize: 30)
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
        view.addSubview(tasksTableView)
        view.addSubview(planTitleLabel)
        view.addSubview(targetLabel)
        view.addSubview(timerLabel)
        view.addSubview(lifeTimeLabel)
        createConstraintsTasksTableView()
        createConstraintsPlanTitleLabel()
        createConstraintsTargetLabel()
        createConstraintsTimerLabel()
        createConstraintsLifeTimeLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    //MARK: Func
    
    
    
    
    //MARK: ConstraintsTableView
    func createConstraintsTasksTableView(){
        tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        tasksTableView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 20).isActive = true
        tasksTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    //MARK: ConstraintsLabel
    func createConstraintsPlanTitleLabel(){
        planTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        planTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func createConstraintsTargetLabel(){
        targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        targetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        targetLabel.topAnchor.constraint(equalTo: planTitleLabel.bottomAnchor, constant: 10).isActive = true
        targetLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createConstraintsTimerLabel(){
        timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        timerLabel.topAnchor.constraint(equalTo: tasksTableView.bottomAnchor, constant: 40).isActive = true
    }
    
    func createConstraintsLifeTimeLabel(){
        lifeTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        lifeTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        lifeTimeLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10).isActive = true
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

