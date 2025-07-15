//
//  SystemKeychainClient.swift
//  Keychain
//
//  Created by Michael Einreinhof on 7/13/25.
//

import Foundation

struct SystemKeychainClient: KeychainClient {
    func add(_ query: CFDictionary) -> OSStatus {
        SecItemAdd(query, nil)
    }

    func update(_ query: CFDictionary, _ attributes: CFDictionary) -> OSStatus {
        SecItemUpdate(query, attributes)
    }

    func copyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<AnyObject?>) -> OSStatus {
        SecItemCopyMatching(query, result)
    }

    func delete(_ query: CFDictionary) -> OSStatus {
        SecItemDelete(query)
    }
}
