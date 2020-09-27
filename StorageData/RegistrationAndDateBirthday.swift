//
//  RegistrationAndDateBirthday.swift
//  NotebookOfLife
//
//  Created by Никита Бычков on 22.06.2020.
//  Copyright © 2020 Никита Бычков. All rights reserved.
//

import Foundation

class RegistrationAndDateBirthday {
    static var dateBirthday: String? {
        get {
            return UserDefaults.standard.string(forKey: "dateBirthday")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "dateBirthday")
        }
    }
    static var targetText: String? {
        get {
            return UserDefaults.standard.string(forKey: "targetText")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "targetText")
        }
    }
    

}
