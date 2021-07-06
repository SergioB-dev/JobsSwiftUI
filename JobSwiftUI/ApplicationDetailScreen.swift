//
//  ApplicationDetailScreen.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/4/21.
//

import SwiftUI

struct ApplicationDetailScreen: View {
    @ObservedObject var nm: NetworkManager
    let application: Application
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60, maximum: 260), spacing: 30)]) {
                ForEach(0..<8){ rect in
                    Color.red
                        .frame(width: 80, height: 100)
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical)
                }
            }
            .padding()
            .navigationTitle(application.company)
        }
    }
}

struct ApplicationDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ApplicationDetailScreen(nm: NetworkManager(), application: Application(company: "Verizon", position: "Junior iOS Dev", hiringManager: "Barry", type: "Application"))
        }
    }
}
