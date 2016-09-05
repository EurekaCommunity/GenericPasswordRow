//
//  Constants.swift
//  GenericPasswordRow
//
//  Created by Diego Ernst on 9/5/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import Foundation
import UIKit

struct Resources {

    static let bundle: NSBundle = {
        var bundle: NSBundle
        if let bundleWithIdentifier = NSBundle(identifier: "com.xmartlabs.GenericPasswordRow") {
            // Example or Carthage
            bundle = bundleWithIdentifier
        } else {
            // Cocoapods
            let podBundle = NSBundle(forClass: GenericPasswordRow.self)
            let bundleURL = podBundle.URLForResource("Frameworks/GenericPasswordRow.framework/GenericPasswordRow", withExtension: "bundle")
            bundle = NSBundle(URL: bundleURL!)!
        }
        return bundle
    }()

    static func image(named named: String) -> UIImage? {
        return UIImage(named: named, inBundle: Resources.bundle, compatibleWithTraitCollection: nil)?.imageWithRenderingMode(.AlwaysTemplate)
    }

}
