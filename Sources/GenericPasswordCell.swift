//
//  GenericPasswordCell.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/6/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import Foundation
import Eureka

public class GenericPasswordCell: Cell<String>, CellType {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var visibilityButton: UIButton?
    @IBOutlet weak var passwordStrengthView: PasswordStrengthView?
    @IBOutlet weak var hintLabel: UILabel?

    var genericPasswordRow: _GenericPasswordRow! {
        return row as? _GenericPasswordRow
    }

    public var visibilityImage: (on: UIImage?, off: UIImage?) {
        didSet {
            setVisibilityButtonImage()
        }
    }

    public var dynamicHeight = (collapsed: UITableViewAutomaticDimension, expanded: UITableViewAutomaticDimension) {
        didSet {
            let value = dynamicHeight
            height = { [weak self] in
                self?.hintLabel?.hidden == true ? value.collapsed : value.expanded
            }
        }
    }

    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    public override func setup() {
        super.setup()
        dynamicHeight = (collapsed: 48, expanded: 64)
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
        textField.keyboardType = .ASCIICapable
        textField.secureTextEntry = true
        selectionStyle = .None
        textField.addTarget(self, action: #selector(GenericPasswordCell.textFieldDidChange(_:)), forControlEvents: .EditingChanged)

        visibilityButton?.addTarget(self, action: #selector(GenericPasswordCell.togglePasswordVisibility), forControlEvents: .TouchUpInside)
        visibilityButton?.tintColor = .grayColor()

        visibilityImage = (on: Resources.image(named: "visibility"), off: Resources.image(named: "visibility_off"))
        hintLabel?.alpha = 0
        passwordStrengthView?.setPasswordValidator(genericPasswordRow.passwordValidator)
        updatePasswordStrengthIfNeeded(animated: false)
    }

    override public func update() {
        super.update()
        textField.text = genericPasswordRow.value
        textField.placeholder = genericPasswordRow.placeholder
    }

    public func togglePasswordVisibility() {
        textField.secureTextEntry = !textField.secureTextEntry
        setVisibilityButtonImage()
        // workaround to update cursor position
        let tmpString = textField.text
        textField.text = nil
        textField.text = tmpString
    }

    private func setVisibilityButtonImage() {
        visibilityButton?.setImage(textField.secureTextEntry ? visibilityImage.on : visibilityImage.off, forState: .Normal)
    }

    public func textFieldDidChange(textField: UITextField) {
        genericPasswordRow.value = textField.text
        updatePasswordStrengthIfNeeded()

        formViewController()?.tableView?.beginUpdates()
        // this updates the height of the cell
        formViewController()?.tableView?.endUpdates()

        UIView.animateWithDuration(0.3, delay: 0.2, options: [], animations: { [weak self] in
            guard let me = self else { return }
            me.hintLabel?.alpha = me.hintLabel?.hidden == true ? 0 : 1
            }, completion: nil)

        // make the cell full visible
        if let indexPath = row?.indexPath() {
            UIView.animateWithDuration(0.3, delay: 0, options: .AllowUserInteraction, animations: { [weak self] in
                self?.formViewController()?.tableView?.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
                }, completion: nil)
        }
    }

    public func updatePasswordStrengthIfNeeded(animated animated: Bool = true) {
        guard let password = textField.text else { return }
        passwordStrengthView?.updateStrength(password: password, animated: animated)
        let hint = genericPasswordRow.passwordValidator.hintForPassword(password)
        hintLabel?.text = hint
        hintLabel?.hidden = hint == nil || password.isEmpty
    }

}
