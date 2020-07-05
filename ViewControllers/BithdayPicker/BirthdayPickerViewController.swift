//
//  BirthdayPickerViewController.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import UIKit
import DWAnimatedLabel

class BirthdayPickerViewController: UIViewController {
    //MARK: View
    lazy var birthdayField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter date of birth"
        textField.font = .systemFont(ofSize: 25)
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
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "NoL"
        label.textAlignment = .center
        label.animationType = .fade
        return label
    }()
    
    lazy var saveBirthdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(saveBirthday), for: .touchUpInside)
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        applicationTitleLabel.startAnimation(duration: 5, .none)
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
        saveBirthdayButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
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
        applicationTitleLabel.startAnimation(duration: 5, nextText: "Notebook of Life", .none)
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
          animation.duration = 0.1
          animation.repeatCount = 5
          animation.autoreverses = true
          animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
          animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
          layer.add(animation, forKey: "position")
      }
}
