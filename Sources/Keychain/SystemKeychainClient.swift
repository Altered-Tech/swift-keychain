//
//  SystemKeychainClient.swift
//  Keychain
//
//  Created by Michael Einreinhof on 7/13/25.
//

import Foundation

public struct SystemKeychainClient: KeychainClient {
    
    public init() {}
    
    public func add(_ query: CFDictionary) -> OSStatus {
        SecItemAdd(query, nil)
    }

    public func update(_ query: CFDictionary, _ attributes: CFDictionary) -> OSStatus {
        SecItemUpdate(query, attributes)
    }

    public func copyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<AnyObject?>) -> OSStatus {
        SecItemCopyMatching(query, result)
    }

    public func delete(_ query: CFDictionary) -> OSStatus {
        SecItemDelete(query)
    }
}
