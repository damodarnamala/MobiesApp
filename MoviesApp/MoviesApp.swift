//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesListView(viewModel: .init())
        }
    }
}
