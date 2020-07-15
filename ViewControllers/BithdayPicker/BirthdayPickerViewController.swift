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
        textField.placeholder = "Enter date of birth"
        textField.textColor = .lightGray
        textField.font = UIFont(name: ".SFUIText-Medium", size: 25)
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 20
        textField.tintColor = .clear
        textField.delegate = self
        return textField
    }()
    
    lazy var applicationTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIText-Medium", size: 40)
        label.textColor = .lightGray
        label.text = "NoL"
        label.textAlignment = .center
        label.animationType = .fade
        return label
    }()
    
    lazy var saveBirthdayButton: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = UIColor(rgb: (153,152,38))
        param.smallShineColor = UIColor(rgb: (102,102,102))
        let button = WCLShineButton(frame: .init(x: 100, y: 100, width: 60, height: 60), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.fillColor = UIColor(rgb: (153,152,38))
        button.color = UIColor(rgb: (170,170,170))
        button.addTarget(self, action: #selector(saveBirthday), for: .valueChanged)
        return button
    }()
    
    lazy var birthdayPicker:  UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.addTarget(self, action: #selector(dateChangedInBithdayPicker), for: .valueChanged)
        return datePicker
    }()
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        birthdayField.inputView = birthdayPicker
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
        applicationTitleLabel.startAnimation(duration: 10, .none)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsField
    func createConstraintsBirthdayField() {
        birthdayField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthdayField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        birthdayField.widthAnchor.constraint(equalToConstant: 250).isActive = true
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
        saveBirthdayButton.topAnchor.constraint(equalTo: birthdayField.bottomAnchor, constant: 10).isActive = true
        saveBirthdayButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        saveBirthdayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func getDateFromBirthdayPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthdayField.text = formatter.string(from: birthdayPicker.date)
    }
    
    //MARK: @objc
    @objc func dateChangedInBithdayPicker() {
        birthdayField.shake()
        applicationTitleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        applicationTitleLabel.animationType = .fade
        applicationTitleLabel.startAnimation(duration: 5, nextText: "NotebookOfLife", .none)
        getDateFromBirthdayPicker()
    }
    
    @objc func saveBirthday() {
        guard birthdayField.text == "" else {
            RegistrationAndDateBirthday.dateBirthday = birthdayField.text
            let viewController = NewDayViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
            return
        }
    }
}
//MARK: Extension
extension BirthdayPickerViewController: UITextFieldDelegate {
    
}

extension UITextField {
    func shake() {
          let animation = CABasicAnimation(keyPath: "position")
          animation.duration = 0.2
          animation.repeatCount = 5
          animation.autoreverses = true
          animation.fromValue = CGPoint(x: self.center.x - 1.0, y: self.center.y)
          animation.toValue = CGPoint(x: self.center.x + 1.0, y: self.center.y)
          layer.add(animation, forKey: "position")
      }
}
