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
    lazy var backgroundSunImageView: UIImageView = {
        let background = UIImage(named: "sunImage.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        return imageView
    }()
    
    lazy var backgroundRainbowImageView: UIImageView = {
        let background = UIImage(named: "rainbowImage.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = background
        return imageView
    }()
    
    lazy var rulesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = .clear
        return view
    }()
    //MARK: Label
     lazy var newDayLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New day!"
        label.font = UIFont(name: "Chalkduster", size: 70)
        label.textColor = .white
        label.animationType = .shine
        return label
    }()
     
    lazy var rulesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Rules for target:\n1)Try not to be longer than this sentence for this purpose!\n2)Start the day with a simple but important goal!"
        label.font = UIFont(name: "Chalkduster", size: 12)
        label.textAlignment = .center
        label.textColor = UIColor(rgb: (105,105,105))
        label.alpha = 0
        return label
    }()
    
    //MARK: Button
    lazy var startNewDayButton: WCLShineButton = {
        var param = WCLShineParams()
        param.enableFlashing = true
        param.animDuration = 1
        param.shineCount = 10
        param.shineSize = 20
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 90, height: 90), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "loveIcon.png")!)
        button.color = .black
        button.fillColor = .black
        button.addTarget(self, action: #selector(startNewDay), for: .valueChanged)
        button.alpha = 0
        return button
    }()
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newDayLabel)
        view.addSubview(startNewDayButton)
        view.addSubview(rulesView)
        view.addSubview(rulesLabel)
        view.addSubview(backgroundSunImageView)
        view.sendSubviewToBack(backgroundSunImageView)
        view.addSubview(backgroundRainbowImageView)
        view.sendSubviewToBack(backgroundRainbowImageView)
        createConstraintsNewDayLabel()
        createConstraintsStartNewDayButton()
        createConstraintsRulesView()
        createConstraintsRulesLabel()
        createConstraintsBackgroundRainbowImageView()
    }
    //MARK: DidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        newDayLabel.startAnimation(duration: 5, .none)
        rulesLabel.fadeInNDVC()
        startNewDayButton.fadeInNDVC()
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsView
    func createConstraintsBackgroundRainbowImageView(){
        backgroundRainbowImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundRainbowImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
    }
    func createConstraintsRulesView(){
        rulesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        rulesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        rulesView.topAnchor.constraint(equalTo: startNewDayButton.bottomAnchor, constant: 5).isActive = true
        rulesView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    //MARK: ConstraintsLabel
    func createConstraintsNewDayLabel() {
        newDayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newDayLabel.bottomAnchor.constraint(equalTo: startNewDayButton.topAnchor, constant: -20).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsStartNewDayButton() {
        startNewDayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startNewDayButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
        startNewDayButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        startNewDayButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func createConstraintsRulesLabel(){
        rulesLabel.topAnchor.constraint(equalTo: rulesView.topAnchor, constant: 10).isActive = true
        rulesLabel.leadingAnchor.constraint(equalTo: rulesView.leadingAnchor, constant: 10).isActive = true
        rulesLabel.trailingAnchor.constraint(lessThanOrEqualTo: rulesView.trailingAnchor, constant: -10).isActive = true
        rulesLabel.bottomAnchor.constraint(lessThanOrEqualTo: rulesView.bottomAnchor, constant: -10).isActive = true
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

extension UIView {
    func fadeInNDVC(duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 1.0
      })
    }
}
