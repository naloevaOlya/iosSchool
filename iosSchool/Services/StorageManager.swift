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

    func saveAppLaunchDate()
    func getAppLaunchDate() -> String

    func saveUserName(username: String)
    func getUserName() -> String

    func cleanUserDefaults()
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
            try keychain.set(token.userId, key: StorageManagerKey.userId.rawValue)
        } catch {
            print(error as Any)
        }
    }

    func getToken() -> TokenResponse? {
        do {
            guard let token = try keychain.get(StorageManagerKey.token.rawValue),
                  let userId = try keychain.get(StorageManagerKey.userId.rawValue) else {
                return nil
            }
            return TokenResponse(token: token, userId: userId)
        } catch {
            print(error as Any)
        }
        return nil
    }

    func removeToken() {
        do {
            try keychain.remove(StorageManagerKey.token.rawValue)
            try keychain.remove(StorageManagerKey.userId.rawValue)
        } catch {
            print(error as Any)
        }
    }

    func saveAppLaunchDate() {
        UserDefaults.standard.set(getDate(), forKey: StorageManagerKey.date.rawValue)
    }

    func getAppLaunchDate() -> String {
        return UserDefaults.standard.string(forKey: StorageManagerKey.date.rawValue) ?? ""
    }

    func saveUserName(username: String) {
        UserDefaults.standard.set(username, forKey: StorageManagerKey.username.rawValue)
    }

    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: StorageManagerKey.username.rawValue) ?? ""
    }

    func cleanUserDefaults() {
        UserDefaults.standard.removeObject(forKey: StorageManagerKey.username.rawValue)
    }
}

private extension StorageManagerImp {

    enum StorageManagerKey: String {
        case notFirstLaunch
        case token
        case userId
        case date
        case username
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

    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM YYYY"
        return formatter.string(from: Date())
    }
}
