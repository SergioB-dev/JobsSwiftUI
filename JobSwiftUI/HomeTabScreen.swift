//
//  HomeTabScreen.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/4/21.
//

import SwiftUI

struct HomeTabScreen: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "")
                    Text("Applications")
                }
        }
    }
}

struct HomeTabScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabScreen()
    }
}
