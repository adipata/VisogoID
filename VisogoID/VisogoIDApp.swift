//
//  VisogoIDApp.swift
//  VisogoID
//
//  Created by Adrian on 19/01/2021.
//

import SwiftUI

@main
struct VisogoIDApp: App {
    var documentData=DocumentData()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(documentData)
        }
    }
}
