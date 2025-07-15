import Testing
@testable import Keychain

@Suite
struct KeychainTests {

    let testService = "testService"
    let testAccount = "testAccount"
    let testData = "mocked data".data(using: .utf8)!

    @Test
    func testSaveAndReadWithMock() {
        let mockClient = MockKeychainClient()
        let keychain = Keychain(service: testService, account: testAccount, client: mockClient)

        keychain.save(testData)
        let result = keychain.read()

        #expect(result == testData)
    }

    @Test
    func testUpdateWithMock() {
        let mockClient = MockKeychainClient()
        let keychain = Keychain(service: testService, account: testAccount, client: mockClient)

        keychain.save("first".data(using: .utf8)!)
        keychain.save("second".data(using: .utf8)!)

        let result = keychain.read()
        #expect(result == "second".data(using: .utf8))
    }

    @Test
    func testDeleteWithMock() {
        let mockClient = MockKeychainClient()
        let keychain = Keychain(service: testService, account: testAccount, client: mockClient)

        keychain.save(testData)
        keychain.delete()

        let result = keychain.read()
        #expect(result == nil)
    }
}
