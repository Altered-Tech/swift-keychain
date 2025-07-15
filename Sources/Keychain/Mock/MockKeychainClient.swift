//
//  MockKeychainClient.swift
//  Keychain
//
//  Created by Michael Einreinhof on 7/13/25.
//

import Foundation
import AuthenticationServices

final class MockKeychainClient: KeychainClient {
    var storage: [String: Data] = [:]

    private func stringValue(from dict: CFDictionary, key: CFString) -> String? {
        let ptr = CFDictionaryGetValue(dict, Unmanaged.passUnretained(key).toOpaque())
        guard let value = ptr else { return nil }
        return unsafeBitCast(value, to: AnyObject.self) as? String
    }

    private func dataValue(from dict: CFDictionary, key: CFString) -> Data? {
        let ptr = CFDictionaryGetValue(dict, Unmanaged.passUnretained(key).toOpaque())
        guard let value = ptr else { return nil }
        return unsafeBitCast(value, to: AnyObject.self) as? Data
    }

    func key(service: String, account: String) -> String {
        return "\(service):\(account)"
    }

    func add(_ query: CFDictionary) -> OSStatus {
        guard let service = stringValue(from: query, key: kSecAttrService),
              let account = stringValue(from: query, key: kSecAttrAccount),
              let data = dataValue(from: query, key: kSecValueData) else {
            return errSecParam
        }

        let compositeKey = key(service: service, account: account)
        if storage[compositeKey] != nil {
            return errSecDuplicateItem
        }

        storage[compositeKey] = data
        return errSecSuccess
    }

    func update(_ query: CFDictionary, _ attributes: CFDictionary) -> OSStatus {
        guard let service = stringValue(from: query, key: kSecAttrService),
              let account = stringValue(from: query, key: kSecAttrAccount),
              let data = dataValue(from: attributes, key: kSecValueData) else {
            return errSecParam
        }

        let compositeKey = key(service: service, account: account)
        storage[compositeKey] = data
        return errSecSuccess
    }

    func copyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<AnyObject?>) -> OSStatus {
        guard let service = stringValue(from: query, key: kSecAttrService),
              let account = stringValue(from: query, key: kSecAttrAccount) else {
            return errSecParam
        }

        let compositeKey = key(service: service, account: account)
        guard let data = storage[compositeKey] else {
            return errSecItemNotFound
        }

        result.pointee = data as NSData
        return errSecSuccess
    }

    func delete(_ query: CFDictionary) -> OSStatus {
        guard let service = stringValue(from: query, key: kSecAttrService),
              let account = stringValue(from: query, key: kSecAttrAccount) else {
            return errSecParam
        }

        let compositeKey = key(service: service, account: account)
        storage.removeValue(forKey: compositeKey)
        return errSecSuccess
    }
}
