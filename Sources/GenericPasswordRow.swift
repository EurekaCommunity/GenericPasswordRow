//
//  PasswordRow.swift
//  Franklin
//
//  Created by Diego Ernst on 5/17/16.
//  Copyright © 2016 Franklin. All rights reserved.
//

import Foundation
import Eureka

public class _GenericPasswordRow: Row<String, GenericPasswordCell> {

    public var passwordValidator: PasswordValidator = DefaultPasswordValidator()
    public var placeholder: String? = "Password"

    public required init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
        cellProvider = CellProvider<GenericPasswordCell>(nibName: "GenericPasswordCell", bundle: Resources.bundle)
    }

    public func isPasswordValid() -> Bool {
        guard let value = value else {
            return false
        }
        return passwordValidator.isPasswordValid(value)
    }

}

public final class GenericPasswordRow: _GenericPasswordRow, RowType { }
