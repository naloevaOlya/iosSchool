//
//  StorageManager.swift
//  iosSchool
//
//  Created by student2 on 24.04.2023.
//

import Foundation
import KeychainAccess

protocol StorageManager {
    func cleanindKeychainIfNeedIt()
    func saveToken(token: TokenResponse?)
    func getToken() -> TokenResponse?
    func removeToken()
}

class StorageManagerImp: StorageManager {

    private let keychain = Keychain(service: Constants.serviceId)

    func cleanindKeychainIfNeedIt() {
        guard !notFirstLaunch() else {
            return
        }
        saveFirstLaunch()
        do {
            try keychain.removeAll()
        } catch {
            print(error as Any)
        }
    }

    func saveToken(token: TokenResponse?) {
        guard let token else {
            return
        }
        do {
            try keychain.set(token.token, key: StorageManagerKey.token.rawValue)
            try keychain.set(token.userid, key: StorageManagerKey.userid.rawValue)
        } catch {
            print(error as Any)
        }
    }

    func getToken() -> TokenResponse? {
        do {
            guard let token = try keychain.get(StorageManagerKey.token.rawValue),
                  let userid = try keychain.get(StorageManagerKey.userid.rawValue) else {
                return nil
            }
            return TokenResponse(token: token, userid: userid)
        } catch {
            print(error as Any)
        }
        return nil
    }

    func removeToken() {
        do {
            try keychain.remove(StorageManagerKey.token.rawValue)
            try keychain.remove(StorageManagerKey.userid.rawValue)
        } catch {
            print(error as Any)
        }
    }
}

private extension StorageManagerImp {

    enum StorageManagerKey: String {
        case notFirstLaunch
        case token
        case userid
    }

    struct Constants {
        static let serviceId = "StorageManagerKeychain.Service.id"
    }

    func notFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: StorageManagerKey.notFirstLaunch.rawValue)
    }

    func saveFirstLaunch() {
        UserDefaults.standard.set(true, forKey: StorageManagerKey.notFirstLaunch.rawValue)
    }
}
