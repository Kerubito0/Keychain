//
//  ContentModel.swift
//  Keychain
//
//  Created by kerubito on 2021/10/12.
//

import Foundation
import SwiftUI

internal class ContentModel: ObservableObject {
    @Published public var userid: String = ""
    @Published public var password: String = ""
    @Published public var useridKeychain: String = ""
    @Published public var passwordKeychain: String = ""
        
    internal init() {
    }
    
    internal func onSave() {
        Keychain().save(id: userid, key: "keychain.sample.com", data: password)
    }
    
    internal func onLoad() {
        passwordKeychain = Keychain().load(id: userid, key: "keychain.sample.com", type: String.self) ?? ""
    }
}

