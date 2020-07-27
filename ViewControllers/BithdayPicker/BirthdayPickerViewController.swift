//
//  BirthdayPickerViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import DWAnimatedLabel
import WCLShineButton

class BirthdayPickerViewController: UIViewController {
    //MARK: View
    lazy var birthdayField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Chalkduster", size: 20)
        textField.placeholder = "Enter date of birth"
        textField.textColor = .lightGray
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.tintColor = .clear
        textField.delegate = self
        return textField
    }()
    
    lazy var applicationTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NoL"
        label.font = UIFont(name: "Chalkduster", size: 55)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.animationType = .shine
        return label
    }()
    
    lazy var saveBirthdayButton: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .white
        param.smallShineColor = .white
        param.shineCount = 0
        param.shineSize = 0
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 60, height: 60), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "dateIcon.png")!)
        button.color = .lightGray
        button.fillColor = .lightGray
        button.addTarget(self, action: #selector(saveBirthday), for: .valueChanged)
        return button
    }()
    
    lazy var birthdayPicker:  UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.setValue(UIColor.lightGray, forKey: "textColor")
        datePicker.datePickerMode = .date
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.addTarget(self, action: #selector(dateChangedInBithdayPicker), for: .valueChanged)
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -100
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        return datePicker
    }()
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(birthdayField)
        view.addSubview(applicationTitleLabel)
        view.addSubview(saveBirthdayButton)
        createConstraintsBirthdayField()
        createConstraintsApplicationTitleLabel()
        createConstraintsSaveBirthdayButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        applicationTitleLabel.startAnimation(duration: 7, .none)
        birthdayField.inputView = birthdayPicker
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.appearVC), userInfo: nil, repeats: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsField
    func createConstraintsBirthdayField() {
        birthdayField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthdayField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        birthdayField.widthAnchor.constraint(equalToConstant: 260).isActive = true
        birthdayField.heightAnchor.constraint(equalToConstant: 50).isActive =  true
    }
    //MARK: ConstraintsLabel
    func createConstraintsApplicationTitleLabel() {
        applicationTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        applicationTitleLabel.bottomAnchor.constraint(equalTo: birthdayField.topAnchor, constant: -10).isActive = true
    }
    //MARK: ConstraintsButton
    func createConstraintsSaveBirthdayButton() {
        saveBirthdayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveBirthdayButton.topAnchor.constraint(equalTo: birthdayField.bottomAnchor, constant: 15).isActive = true
        saveBirthdayButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        saveBirthdayButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func getDateFromBirthdayPicker() {
        addAnimationSaveBirthdayButton()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthdayField.text = formatter.string(from: birthdayPicker.date)
        birthdayField.font = UIFont(name: "Chalkduster", size: 25)
    }
    
    func addAnimationSaveBirthdayButton() {
        saveBirthdayButton.params.enableFlashing = true
        saveBirthdayButton.params.animDuration = 1
        saveBirthdayButton.params.shineCount = 10
        saveBirthdayButton.params.shineSize = 12
        saveBirthdayButton.fillColor = UIColor(rgb: (153,152,38))
    }
    
    func changeTextApplicationTitleLabel() {
        guard applicationTitleLabel.text == "NotebookOfLife" else {
            applicationTitleLabel.text = "NotebookOfLife"
            applicationTitleLabel.font = UIFont(name: "Chalkduster", size: 35)
            applicationTitleLabel.animationType = .shine
            applicationTitleLabel.startAnimation(duration: 7, .none)
            return
        }
    }
    //MARK: @objc
    @objc func dateChangedInBithdayPicker() {
        changeTextApplicationTitleLabel()
        getDateFromBirthdayPicker()
        birthdayField.shakeTextFieldBPVC()
    }
    
    @objc func saveBirthday() {
        if birthdayField.text == "" {
            birthdayField.attentionTextFieldBPVC()
        } else {
            RegistrationAndDateBirthday.dateBirthday = birthdayField.text
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.transitionDelayNewDayViewController), userInfo: nil, repeats: false)
        }
    }
    
    @objc func transitionDelayNewDayViewController() {
        let viewController = NewDayViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func appearVC() {
        birthdayField.attentionTextFieldBPVC()
    }
}
//MARK: Extension
extension BirthdayPickerViewController: UITextFieldDelegate {
}

extension UITextField {
    func shakeTextFieldBPVC() {
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.x")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 1
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.02
        layer.add(animationTwo, forKey: "transform.scale.x")
      }
    
    func attentionTextFieldBPVC() {
        let animationOne = CABasicAnimation(keyPath: "transform.scale.x")
        animationOne.duration = 0.3
        animationOne.repeatCount = 2
        animationOne.autoreverses = true
        animationOne.fromValue = 1
        animationOne.toValue = 1.04
        layer.add(animationOne, forKey: "transform.scale.x")
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.y")
        animationTwo.duration = 0.3
        animationTwo.repeatCount = 2
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.04
        layer.add(animationTwo, forKey: "transform.scale.y")
    }
}
