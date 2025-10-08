//
//  KeychainClient.swift
//  Keychain
//
//  Created by Michael Einreinhof on 7/13/25.
//


import Foundation

public protocol KeychainClient {
    public func add(_ query: CFDictionary) -> OSStatus
    public func update(_ query: CFDictionary, _ attributes: CFDictionary) -> OSStatus
    public func copyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<AnyObject?>) -> OSStatus
    public func delete(_ query: CFDictionary) -> OSStatus
}
