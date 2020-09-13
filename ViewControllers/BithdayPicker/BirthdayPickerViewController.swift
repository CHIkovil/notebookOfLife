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
    lazy var backgroundTreeImageView: UIImageView = {
        let background = UIImage(named: "treeImage.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        return imageView
    }()
    
    //MARK: Field
    lazy var birthdayField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Chalkduster", size: 21)
        textField.text = "Enter date of birth"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.layer.cornerRadius = 30
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.tintColor = .clear
        textField.alpha = 0
        textField.delegate = self
        return textField
    }()
    //MARK: Label
    lazy var applicationTitleLabel: DWAnimatedLabel = {
        let label = DWAnimatedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NoL"
        label.font = UIFont(name: "Chalkduster", size: 65)
        label.textColor = .white
        label.textAlignment = .center
        label.animationType = .shine
        return label
    }()
    //MARK: Button
    lazy var saveBirthdayButton: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .white
        param.smallShineColor = .white
        param.shineCount = 0
        param.shineSize = 0
        let button = WCLShineButton(frame: .init(x: 0, y: 0, width: 70, height: 70), params: param)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = .custom(UIImage(named: "calendarIcon.png")!)
        button.color = .black
        button.fillColor = .black
        button.alpha = 0
        button.addTarget(self, action: #selector(saveBirthday), for: .valueChanged)
        return button
    }()
    //MARK: Picker
    lazy var birthdayPicker:  UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor(rgb: (240, 220, 130))
        datePicker.setValue(UIColor(rgb: (105,105,105)), forKey: "textColor")
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
        view.addSubview(birthdayField)
        view.addSubview(applicationTitleLabel)
        view.addSubview(saveBirthdayButton)
        view.addSubview(backgroundTreeImageView)
        view.sendSubviewToBack(backgroundTreeImageView)
        createConstraintsBirthdayField()
        createConstraintsApplicationTitleLabel()
        createConstraintsSaveBirthdayButton()
        
    }
    //MARK: DidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        applicationTitleLabel.startAnimation(duration: 7, .none)
        birthdayField.inputView = birthdayPicker
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.appearVC), userInfo: nil, repeats: false)
        birthdayField.fadeInBPVC()
        saveBirthdayButton.fadeInBPVC()
    }
    //MARK: touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //MARK: Func
    
    
    
    //MARK: ConstraintsField
    func createConstraintsBirthdayField() {
        birthdayField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthdayField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        birthdayField.widthAnchor.constraint(equalToConstant: 280).isActive = true
        birthdayField.heightAnchor.constraint(equalToConstant: 60).isActive =  true
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
        saveBirthdayButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        saveBirthdayButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    //MARK: getDateFromBirthdayPicker
    func getDateFromBirthdayPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthdayField.text = formatter.string(from: birthdayPicker.date)
        birthdayField.font = UIFont(name: "Chalkduster", size: 30)
    }
    //MARK: addAnimationSaveBirthdayButton
    func addAnimationSaveBirthdayButton() {
        saveBirthdayButton.params.enableFlashing = true
        saveBirthdayButton.params.animDuration = 1.2
        saveBirthdayButton.params.shineCount = 10
        saveBirthdayButton.params.shineSize = 25
    }
    //MARK:changeTextApplicationTitleLabel
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
        addAnimationSaveBirthdayButton()
        changeTextApplicationTitleLabel()
        getDateFromBirthdayPicker()
        birthdayField.shakeTextFieldBPVC()
    }
    
    @objc func saveBirthday() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        if birthdayField.text == "" || birthdayField.text == "Enter date of birth" {
            birthdayField.attentionTextFieldBPVC()
        } else {
            RegistrationAndDateBirthday.dateBirthday = birthdayField.text
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.transitionDelayNewDayViewController), userInfo: nil, repeats: false)
        }
    }
    
    @objc func transitionDelayNewDayViewController() {
        let viewController = NewDayViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .partialCurl
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func appearVC() {
        birthdayField.attentionTextFieldBPVC()
    }
}
//MARK: Extension
extension BirthdayPickerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
            return true
        } else {
            return false
        }
    }
}

extension UITextField {
    func shakeTextFieldBPVC() {
        let animationTwo = CABasicAnimation(keyPath: "transform.scale.x")
        animationTwo.duration = 0.35
        animationTwo.repeatCount = 1
        animationTwo.autoreverses = true
        animationTwo.fromValue = 1
        animationTwo.toValue = 1.03
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

extension UIView {
    func fadeInBPVC(duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 1.0
      })
    }
}

extension  BirthdayPickerViewController : UIGestureRecognizerDelegate {
    func  gestureRecognizer ( _  gestureRecognizer : UIGestureRecognizer, shouldReceive  touch : UITouch) ->  Bool {
        let isControllTapped = touch.view  is UIControl
        return  !isControllTapped
    }
}
