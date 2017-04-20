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
    func strengthForPassword(_ password: String) -> Double
    func hintForPassword(_ password: String) -> String?
    func isPasswordValid(_ password: String) -> Bool
    func colorsForStrengths() -> [Double: UIColor]

}
