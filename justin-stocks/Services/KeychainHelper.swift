//
//  KeychainHelper.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
//

import Foundation
import Security

struct KeychainHelper {
    static func save(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary) // Remove existing item
            SecItemAdd(query as CFDictionary, nil)
        }
    }

    static func retrieve(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess {
            if let data = result as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }

    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        SecItemDelete(query as CFDictionary)
    }
}
