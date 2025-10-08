//
//  KeychainClient.swift
//  Keychain
//
//  Created by Michael Einreinhof on 7/13/25.
//


import Foundation

public protocol KeychainClient {
    func add(_ query: CFDictionary) -> OSStatus
    func update(_ query: CFDictionary, _ attributes: CFDictionary) -> OSStatus
    func copyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<AnyObject?>) -> OSStatus
    func delete(_ query: CFDictionary) -> OSStatus
}
