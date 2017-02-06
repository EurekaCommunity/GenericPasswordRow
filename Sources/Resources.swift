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
        var bundle = Bundle(for: GenericPasswordRow.self)
        let bundleURL = bundle.url(forResource: "GenericPasswordRow", withExtension: "bundle")
        if let bundleURL = bundleURL  {
            bundle = Bundle(url: bundleURL)!
        }
        return bundle
    }()

    static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: Resources.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }

}
