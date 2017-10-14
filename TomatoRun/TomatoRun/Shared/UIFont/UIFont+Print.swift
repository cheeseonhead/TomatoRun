//
//  UIFont+Print.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/11/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension UIFont {
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}
