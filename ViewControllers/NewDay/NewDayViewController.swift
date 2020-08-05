//
//  NewDayViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import DWAnimatedLabel
import WCLShineButton

class NewDayViewController: UIViewController {
    //MARK: View
     lazy var newDayLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New day!"
        label.font = UIFont(name: "Chalkduster", size: 60)
        label.textColor = .lightGray
        label.animationType = .shine
        return label
    }()
    
    lazy var startNewDayButton: WCLShineButton = {
        var param = WCLShineParams()
        param.enableFlashing = true
        param.animDuration = 1
        param.shineCount = 10
        param.shineSize = 15
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 90, height: 90), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "handshakeIcon.png")!)
        button.color = .lightGray
        button.fillColor = UIColor(rgb: (255,127,80))
        button.addTarget(self, action: #selector(startNewDay), for: .valueChanged)
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
        newDayLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -5).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsStartNewDayButton() {
        startNewDayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startNewDayButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 7).isActive = true
        startNewDayButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        startNewDayButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    //MARK: @objc
    @objc func startNewDay() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.transitionDelayInputPlanViewController), userInfo: nil, repeats: false)
    }
    
    @objc func transitionDelayInputPlanViewController() {
        let viewController = InputPlanViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .partialCurl
        self.present(viewController, animated: true, completion: nil)
    }
}
