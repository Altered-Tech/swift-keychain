//
//  Keychain.swift
//  swift-keychain
//
//  Created by Michael Einreinhof on 7/13/25.
//

// This is from https://www.swiftdevjournal.com/saving-passwords-in-the-keychain-in-swift/

import AuthenticationServices

class Keychain {
    let service: String
    let account: String
    let client: KeychainClient

    init(service: String, account: String, client: KeychainClient = SystemKeychainClient()) {
        self.service = service
        self.account = account
        self.client = client
    }

    func save(_ data: Data) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let status = client.add(query)

        if status == errSecDuplicateItem {
            update(data)
        }
    }

    func update(_ data: Data) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let attributes = [kSecValueData: data] as CFDictionary
        let _ = client.update(query, attributes)
    }

    func read() -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = client.copyMatching(query, &result)

        return (status == errSecSuccess) ? result as? Data : nil
    }

    func delete() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let _ = client.delete(query)
    }
}
