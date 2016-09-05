//
//  PasswordValidator.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/6/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import UIKit

public protocol PasswordValidator {

    var maxStrength: Double { get }
    func strengthForPassword(password: String) -> Double
    func hintForPassword(password: String) -> String?
    func isPasswordValid(password: String) -> Bool
    func colorsForStrengths() -> [Double: UIColor]

}
