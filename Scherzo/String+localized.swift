//
//  String+localized.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 16.01.2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
