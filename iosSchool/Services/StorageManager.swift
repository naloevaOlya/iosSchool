//
//  StorageManager.swift
//  iosSchool
//
//  Created by student2 on 24.04.2023.
//

import UIKit
import Foundation
import KeychainAccess

protocol StorageManager {
    func cleaningKeychainIfNeedIt()
    func saveToken(token: TokenResponse?)
    func getToken() -> TokenResponse?
    func removeToken()

    func saveAppLaunchDate()
    func getAppLaunchDate() -> String

    func saveUserName(username: String)
    func getUserName() -> String

    func saveUserPhoto(photo: UIImage)
    func getUserPhoto() -> UIImage?
    func removeUserPhoto()

    func cleanUserDefaults()

    func saveProfileColor(color: UIColor?)
    func getProfileColor() -> UIColor?
}

class StorageManagerImp: StorageManager {

    private let keychain = Keychain(service: Constants.serviceId)

    func cleaningKeychainIfNeedIt() {
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
        UserDefaults.standard.string(forKey: StorageManagerKey.date.rawValue) ?? ""
    }

    func saveUserName(username: String) {
        UserDefaults.standard.set(username, forKey: StorageManagerKey.username.rawValue)
    }

    func getUserName() -> String {
        UserDefaults.standard.string(forKey: StorageManagerKey.username.rawValue) ?? ""
    }

    func saveUserPhoto(photo: UIImage) {
        guard let data = photo.jpegData(compressionQuality: 0.5) else {
            return
        }
        let encoded = try? PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: StorageManagerKey.photo.rawValue)
    }

    func getUserPhoto() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: StorageManagerKey.photo.rawValue),
              let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else {
            return nil
        }
        return UIImage(data: decoded)
    }

    func removeUserPhoto() {
        UserDefaults.standard.removeObject(forKey: StorageManagerKey.photo.rawValue)
    }

    func cleanUserDefaults() {
        UserDefaults.standard.removeObject(forKey: StorageManagerKey.username.rawValue)
        UserDefaults.standard.removeObject(forKey: StorageManagerKey.profileColor.rawValue)
        removeUserPhoto()
    }

    func saveProfileColor(color: UIColor?) {
        UserDefaults.standard.set(fromUColorToString(color: color), forKey: StorageManagerKey.profileColor.rawValue)
    }

    func getProfileColor() -> UIColor? {
        fromStringToColor(color: UserDefaults.standard.string(forKey: StorageManagerKey.profileColor.rawValue))
    }
}

private extension StorageManagerImp {

    enum StorageManagerKey: String {
        case notFirstLaunch
        case token
        case userId
        case date
        case username
        case profileColor
        case photo
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

    func fromUColorToString(color: UIColor?) -> String {
        guard let color, let components = color.cgColor.components else {
            return "[255, 255, 255, 255]"
        }
        return "[\(components[0]), \(components[1]), \(components[2]), \(components[3])]"
    }

    func fromStringToColor(color: String?) -> UIColor? {
        guard let color, !color.isEmpty else {
            return nil
        }
        let componentsString = color.replacing("[", with: "").replacing("]", with: "")
        let components = componentsString.components(separatedBy: ", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                     green: CGFloat((components[1] as NSString).floatValue),
                     blue: CGFloat((components[2] as NSString).floatValue),
                     alpha: CGFloat((components[3] as NSString).floatValue))
    }
}
