//
//  PasswordStrengthView.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/1/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import UIKit

public class DefaultPasswordStrengthView: PasswordStrengthView {

    public typealias StrengthView = (view: UIView, p: CGFloat, color: UIColor)
    public var strengthViews: [StrengthView]!
    public var validator: PasswordValidator!

    public var progressView: UIView!
    public var progress: CGFloat = 0

    public var borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.2)
    public var borderWidth = CGFloat(1)
    public var cornerRadius = CGFloat(3)
    public var animationTime = NSTimeInterval(0.3)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public func setPasswordValidator(validator: PasswordValidator) {
        self.validator = validator
        let colorsForStrenghts = validator.colorsForStrengths().sort { $0.0 < $1.0 }
        strengthViews = colorsForStrenghts.enumerate().map { index, element in
            let view = UIView()
            view.layer.borderColor = borderColor.CGColor
            view.layer.borderWidth = borderWidth
            view.backgroundColor = backgroundColorForStrenghColor(element.1)
            let r = index < colorsForStrenghts.count - 1 ? colorsForStrenghts[index+1].0 : validator.maxStrength
            return (view: view, p: CGFloat(r / validator.maxStrength), color: element.1)
        }
        strengthViews.reverse().forEach { addSubview($0.view) }
        bringSubviewToFront(progressView)
    }

    public func backgroundColorForStrenghColor(color: UIColor) -> UIColor {
        var h = CGFloat(0), s = CGFloat(0), b = CGFloat(0), alpha = CGFloat(0)
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &alpha)
        return UIColor(hue: h, saturation: 0.06, brightness: 1, alpha: alpha)
    }

    public func setup() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        progressView = UIView()
        progressView.layer.borderColor = borderColor.CGColor
        progressView.layer.borderWidth = borderWidth
        addSubview(progressView)
        progress = 0
    }

    override public func updateStrength(password password: String, animated: Bool = true) {
        let strength = validator.strengthForPassword(password)
        progress = CGFloat(strength / validator.maxStrength)
        updateView(animated: animated)
    }

    public func colorForProgress() -> UIColor {
        for strengthView in strengthViews {
            if progress <= strengthView.p {
                return strengthView.color
            }
        }
        return strengthViews.last?.color ?? .clearColor()
    }

    public func updateView(animated animated: Bool) {
        setNeedsLayout()
        if animated {
            UIView.animateWithDuration(animationTime, animations: { [weak self] in
                self?.layoutIfNeeded()
            }, completion: { [weak self] _ in
                UIView.animateWithDuration(self?.animationTime ?? 0.3) { [weak self] in
                    self?.progressView?.backgroundColor = self?.colorForProgress()
                }
            })
        } else {
            layoutIfNeeded()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        var size = frame.size
        size.width = size.width * progress
        progressView.frame = CGRect(origin: CGPoint.zero, size: size)

        strengthViews.forEach { view, p, _ in
            var size = frame.size
            size.width = size.width * p
            view.frame = CGRect(origin: CGPoint.zero, size: size)
        }
    }

}
