//
//  ContentView.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/3/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var networkManager = NetworkManager()
    @State private var showAddScreen = false
    @State private var showListScreen = false
    var body: some View {
        ScrollView {
            HStack {
                LazyVGrid(columns: gridStyle) {
                    ForEach(actions, id: \.self) { action in
                            OptionView(networkManager: networkManager,showAddScreen: $showAddScreen, showListScreen: $showListScreen, action: action, width: 280, height: 400)
                    }
                }
                
                .task {
                    do {
                        try await getAppCount()
                    } catch let error {
                        print(error)
                    }

                }
            }
            NavigationLink("", destination: AddScreen(nm: networkManager), isActive: $showAddScreen)
            NavigationLink("", destination: ApplicationListScreen(nm: networkManager), isActive: $showListScreen)
            
            .onAppear {
                networkManager.getAllApplications { result in
                    switch result {
                    case .success(let applications):
                        DispatchQueue.main.async {
                            networkManager.applications = applications
                        }
                        
                        print("Number should update to \(applications.count)")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
     func getAppCount() async throws {
        let data = try await URLSession.shared.data(from: URL(string: "http://localhost:8080/applications")!)
        do {
            let loadedInfo = try JSONDecoder().decode([Application].self, from: data.0)
            print(loadedInfo)
            DispatchQueue.main.async {
                networkManager.applications = loadedInfo
            }
        } catch let error {
            print(error)
        }
    }
    let gridStyle = [GridItem(.fixed(100), spacing: 20, alignment: .center)]
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

let actions = ["POST", "GET", "DELETE", "PUT"]
