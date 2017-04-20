//
//  PasswordStrengthView.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/6/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import UIKit

open class PasswordStrengthView: UIView {

    open func setPasswordValidator(_ validator: PasswordValidator) { }
    open func updateStrength(password: String, animated: Bool = true) { }

}
