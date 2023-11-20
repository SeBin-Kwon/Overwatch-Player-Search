//
//  OverwatchAPIApp.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/15/23.
//

import SwiftUI

@main
struct OverwatchAPIApp: App {
    @StateObject var viewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
