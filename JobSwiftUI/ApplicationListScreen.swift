//
//  ApplicationListScreen.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/4/21.
//

import SwiftUI

struct ApplicationListScreen: View {
    @ObservedObject var nm: NetworkManager
    var junioriOSDev: [Application] {
     nm.applications.filter{$0.position == "Junior iOS Dev"}
    }
    var fullStackiOSDev: [Application] {
        nm.applications.filter{ $0.position == "Full Stack iOS Dev"}

    }
    var senioriOSDev: [Application] {
        nm.applications.filter{ $0.position == "Senior iOS Dev"}
    }
    var intern: [Application] {
        nm.applications.filter {$0.position == "Intern"}
    }
    
    var other: [Application] {
        nm.applications.filter {
            $0.position != "Junior iOS Dev" &&
            $0.position != "Full Stack iOS Dev" &&
            $0.position != "Senior iOS Dev" &&
            $0.position != "Intern"
        }
    }
    var body: some View {
        VStack {
            List {
                Section(header: headerView(title: "Junior iOS Dev", image: "babyBirdOrange")) {
                    ForEach(junioriOSDev) { app in
                        NavigationLink(destination: ApplicationDetailScreen(nm: nm, application: app)) {
                            Text(app.company)
                                .swipeActions {
                                    Button(action: {
                                        withAnimation {
                                        delete(appID: app.id!)}
                                    }
                                    ){
                                        Image(systemName: "trash.fill")
                                            
                                    }.tint(.red)
                            }
                        }
                    }
                }
                Section(header: headerView(title: "Senios iOS Dev", image: "senioriOSDev")) {
                    ForEach(senioriOSDev){  app in
                        Text(app.company)
                            .swipeActions {
                                Button(action: {delete(appID: app.id!)}){
                                    Image(systemName: "trash.fill")
                                        
                                }.tint(.red)
                            }
                    }
                }
                Section(header: headerView(title: "Full Stack iOS Dev", image: "fullStack")) {
                    ForEach(fullStackiOSDev){  app in
                        Text(app.company)
                            .swipeActions {
                                Button(action: {delete(appID: app.id!)}){
                                    Image(systemName: "trash.fill")
                                        
                                }.tint(.red)
                            }
                    }
                }
                Section(header: headerView(title: "Intern", image: "teamLeaderOrange")) {
                    ForEach(intern){  app in
                        Text(app.company)
                            .swipeActions {
                                Button(action: {delete(appID: app.id!)}){
                                    Image(systemName: "trash.fill")
                                        
                                }.tint(.red)
                            }
                    }
                }
                Section(header: Text("Other")) {
                    ForEach(other){  app in
                        Text(app.company)
                            .swipeActions {
                                Button(action: {delete(appID: app.id!)}){
                                    Image(systemName: "trash.fill")
                                        
                                }.tint(.red)
                            }
                    }
                }
                
            }
        }
    }
    private func delete(appID: String) {
        nm.deleteApplication(appID: appID) {
            nm.getAllApplications { result in
                switch result {
                case .success(let applications):
                    DispatchQueue.main.async {
                        withAnimation {
                        nm.applications = applications
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @ViewBuilder private func headerView(title: String, image: String) -> some View {
        HStack {
            Text(title)
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
        }
    }
}

struct ApplicationListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationListScreen(nm: NetworkManager())
    }
}
