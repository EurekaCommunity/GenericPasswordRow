//
//  PasswordStrengthView.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/1/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import UIKit

open class DefaultPasswordStrengthView: PasswordStrengthView {

    public typealias StrengthView = (view: UIView, p: CGFloat, color: UIColor)
    open var strengthViews: [StrengthView]!
    open var validator: PasswordValidator!

    open var progressView: UIView!
    open var progress: CGFloat = 0

    open var borderColor = UIColor.lightGray.withAlphaComponent(0.2)
    open var borderWidth = CGFloat(1)
    open var cornerRadius = CGFloat(3)
    open var animationTime = TimeInterval(0.3)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override open func setPasswordValidator(_ validator: PasswordValidator) {
        self.validator = validator
        let colorsForStrenghts = validator.colorsForStrengths().sorted { $0.0 < $1.0 }
        strengthViews = colorsForStrenghts.enumerated().map { index, element in
            let view = UIView()
            view.layer.borderColor = borderColor.cgColor
            view.layer.borderWidth = borderWidth
            view.backgroundColor = backgroundColorForStrenghColor(element.1)
            let r = index < colorsForStrenghts.count - 1 ? colorsForStrenghts[index+1].0 : validator.maxStrength
            return (view: view, p: CGFloat(r / validator.maxStrength), color: element.1)
        }
        strengthViews.reversed().forEach { addSubview($0.view) }
        bringSubview(toFront: progressView)
    }

    open func backgroundColorForStrenghColor(_ color: UIColor) -> UIColor {
        var h = CGFloat(0), s = CGFloat(0), b = CGFloat(0), alpha = CGFloat(0)
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &alpha)
        return UIColor(hue: h, saturation: 0.06, brightness: 1, alpha: alpha)
    }

    open func setup() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        progressView = UIView()
        progressView.layer.borderColor = borderColor.cgColor
        progressView.layer.borderWidth = borderWidth
        addSubview(progressView)
        progress = 0
    }

    override open func updateStrength(password: String, animated: Bool = true) {
        let strength = validator.strengthForPassword(password)
        progress = CGFloat(strength / validator.maxStrength)
        updateView(animated: animated)
    }

    open func colorForProgress() -> UIColor {
        for strengthView in strengthViews {
            if progress <= strengthView.p {
                return strengthView.color
            }
        }
        return strengthViews.last?.color ?? .clear
    }

    open func updateView(animated: Bool) {
        setNeedsLayout()
        if animated {
            UIView.animate(withDuration: animationTime, animations: { [weak self] in
                self?.layoutIfNeeded()
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: self?.animationTime ?? 0.3, animations: { [weak self] in
                    self?.progressView?.backgroundColor = self?.colorForProgress()
                }) 
            })
        } else {
            layoutIfNeeded()
        }
    }

    override open func layoutSubviews() {
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
