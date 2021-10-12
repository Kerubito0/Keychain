//
//  ContentView.swift
//  Keychain
//
//  Created by kerubito on 2021/10/12.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var model = ContentModel()
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("", text: $model.userid)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            TextField("", text: $model.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            
            Text("キーチェーンに保存されたパスワード：\(model.passwordKeychain)")
            
            Button(action: {
                model.onSave()
            }) { Text("キーチェーンに保存").frame(width: 300, height: 45) }
            
            Button(action: {
                model.onLoad()
            }) { Text("キーチェーンから読み出し").frame(width: 300, height: 45) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
