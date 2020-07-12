//
//  NewDayViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import DWAnimatedLabel

class NewDayViewController: UIViewController {
    //MARK: View
     lazy var newDayLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New day!"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.animationType = .shine
        return label
    }()
    
    lazy var startNewDayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(startNewDay), for: .touchUpInside)
        return button
    }()
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newDayLabel)
        view.addSubview(startNewDayButton)
        createConstraintsNewDayLabel()
        createConstraintsStartNewDayButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        newDayLabel.startAnimation(duration: 5, .none)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsLabel
    func createConstraintsNewDayLabel() {
        newDayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newDayLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -7).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsStartNewDayButton() {
        startNewDayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startNewDayButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 7).isActive = true
        startNewDayButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startNewDayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //MARK: @objc
    @objc func startNewDay() {
        let viewController = InputPlanViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
