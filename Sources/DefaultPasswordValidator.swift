//
//  PasswordValidatorEngine.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/1/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import UIKit
import Foundation

public struct PasswordRule {

    let hint: String
    let test: (String) -> Bool

}

open class DefaultPasswordValidator: PasswordValidator {

    open let maxStrength = 4.0

    let rules: [PasswordRule] = [
        PasswordRule(hint: NSLocalizedString("Please enter a lowercase letter", comment: "")) { $0.satisfiesRegexp("[a-z]") },
        PasswordRule(hint: NSLocalizedString("Please enter a number", comment: "")) { $0.satisfiesRegexp("[0-9]") },
        PasswordRule(hint: NSLocalizedString("Please enter an uppercase letter", comment: "")) { $0.satisfiesRegexp("[A-Z]") },
        PasswordRule(hint: NSLocalizedString("At least 6 characters", comment: "")) { $0.characters.count > 5 }
    ]

    open func strengthForPassword(_ password: String) -> Double {
        return rules.reduce(0) { $0 + ($1.test(password) ? 1 : 0) }
    }

    open func hintForPassword(_ password: String) -> String? {
        return rules.reduce([]) { $0 + ($1.test(password) ? []: [$1.hint]) }.first
    }

    open func isPasswordValid(_ password: String) -> Bool {
        return rules.reduce(true) { $0 && $1.test(password) }
    }

    open func colorsForStrengths() -> [Double: UIColor] {
        return [
            0: UIColor(red: 244 / 255, green: 67 / 255, blue: 54 / 255, alpha: 1),
            1: UIColor(red: 255 / 255, green: 193 / 255, blue: 7 / 255, alpha: 1),
            2: UIColor(red: 3 / 255, green: 169 / 255, blue: 244 / 255, alpha: 1),
            3: UIColor(red: 139 / 255, green: 195 / 255, blue: 74 / 255, alpha: 1)
        ]
    }

}

internal extension String {

    func satisfiesRegexp(_ regexp: String) -> Bool {
        return range(of: regexp, options: .regularExpression) != nil
    }

}
