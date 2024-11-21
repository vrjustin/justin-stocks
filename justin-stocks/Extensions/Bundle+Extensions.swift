//
//  Bundle+Extensions.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/21/24.
//

import Foundation

extension Bundle {
    var appVersion: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0"
    }
}
