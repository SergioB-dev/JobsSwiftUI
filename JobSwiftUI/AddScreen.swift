//
//  AddScreen.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/3/21.
//

import SwiftUI

struct AddScreen: View {
    @ObservedObject var nm: NetworkManager
    @State private var company = ""
    @State private var position = ""
    @State private var hiringManager = ""
    @State private var type = ""
    @Environment(\.presentationMode) var pm
    
    var body: some View {
        VStack {
            Form {
                TextField("Company", text: $company)
                TextField("Position", text: $position)
                TextField("Hiring Manager", text: $hiringManager)
                TextField("Type", text: $type)
                HStack {
                    Button(action: reset){
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                Button("Upload"){
                    guard !company.isEmpty, !position.isEmpty, !hiringManager.isEmpty, !type.isEmpty else { return }
                    
                    nm.postApplication(company: company, position: position, hiringManager: hiringManager, type: type)
                    
                    
                }
                }
            }
            PositionSelectionView(position: $position)
        }
    }
    private func reset() {
        self.pm.wrappedValue.dismiss()
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen(nm: NetworkManager())
    }
}


