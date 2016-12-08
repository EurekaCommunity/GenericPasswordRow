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

    static let bundle: Bundle = {
        var bundle: Bundle
        if let bundleWithIdentifier = Bundle(identifier: "com.xmartlabs.GenericPasswordRow") {
            // Example or Carthage
            bundle = bundleWithIdentifier
        } else {
            // Cocoapods
            let podBundle = Bundle(for: GenericPasswordRow.self)
            let bundleURL = podBundle.url(forResource: "Frameworks/GenericPasswordRow.framework/GenericPasswordRow", withExtension: "bundle")
            bundle = Bundle(url: bundleURL!)!
        }
        return bundle
    }()

    static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: Resources.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }

}
