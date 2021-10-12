//
//  Keychain.swift
//  Keychain
//
//  Created by kerubito on 2021/10/12.
//

import Foundation

public struct Keychain {
    public init() {}
    public func save<T: Codable>(id: String, key: String, data: T) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(data)
            
            let query: [String: Any] = [
                kSecClass              as String: kSecClassGenericPassword,
                kSecAttrService        as String: key,
                kSecAttrAccount        as String: id,
                kSecValueData          as String: encoded,
            ]
            
            let status = SecItemCopyMatching(query as CFDictionary, nil)
            switch status {
            case errSecItemNotFound:
                SecItemAdd(query as CFDictionary, nil)
            case errSecSuccess:
                SecItemUpdate(query as CFDictionary, [kSecValueData as String: encoded] as CFDictionary)
            default:
                print("該当なし")
            }
        } catch {
            print("エラー")
        }
    }
    
    public func load<T: Codable>(id: String, key: String, type: T.Type) -> T? {
        let query: [String: Any] = [
            kSecClass              as String: kSecClassGenericPassword,
            kSecAttrService        as String: key,
            kSecAttrAccount        as String: id,
            kSecMatchLimit         as String: kSecMatchLimitOne,
            kSecReturnAttributes   as String: true,
            kSecReturnData         as String: true,
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        switch status {
        case errSecItemNotFound:
            return nil
        case errSecSuccess:
            guard let item = item,
                  let value = item[kSecValueData as String] as? Data else {
                      print("データなし")
                      return nil
                  }
            do {
                return try JSONDecoder().decode(type, from: value)
            } catch {
                print("エラー")
            }
        default:
            print("該当なし")
        }
        return nil
    }
}
