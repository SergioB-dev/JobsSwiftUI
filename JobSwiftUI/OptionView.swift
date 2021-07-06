//
//  OptionView.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/3/21.
//

import SwiftUI

struct OptionView: View {
    @ObservedObject var networkManager: NetworkManager
    @Binding var showAddScreen: Bool
    @Binding var showListScreen: Bool
    let width: CGFloat
    let height: CGFloat
    let action: String
    let networkAction: NetworkAction
    var  networkCallBack:  () -> Void {
        switch action {
        case "POST":
            return  {
                print("POSTING")
                self.showAddScreen = true
                
            }
        case "GET":
           return {
               print("GETTING")
               self.showListScreen = true
           }
        case "DELETE":
            return  { print("DELETING")}
        default:
            return  { print("UPDATING")}
            
        }
    }
    init(networkManager: NetworkManager, showAddScreen: Binding<Bool>,
         showListScreen: Binding<Bool>, action: String, width: CGFloat, height: CGFloat) {
        self.networkManager = networkManager
        self._showAddScreen = showAddScreen
        self._showListScreen = showListScreen
        self.action = action
        self.width = width
        self.height = height
       
        switch action {
        case "POST":
            networkAction = .post

        case "GET":
            networkAction = .get
        case "DELETE":
            networkAction = .delete
        default:
            networkAction = .update

            
        }
        
    }
    
    var body: some View {
        Button(action: {networkCallBack() }) {
            HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: width, height: height)
                                .padding()
                            VStack {
                                Text(networkAction.title + " Application")
                                    .font(.custom("ComicSans", size: 30))
                                    .foregroundColor(networkAction.accentColor)
                                networkAction.image
                                    .resizable()
                                    .position(x: 120, y: -130)
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .foregroundColor(networkAction.accentColor)
                                Image(systemName: "\(networkManager.applications.count).circle")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .scaledToFit()
                                    .foregroundColor(networkAction.accentColor)
                            }
                        }
                   
                    Spacer()
            }

        }.buttonStyle(.plain)
        
    }
    
    private func showModal() {
        self.showAddScreen.toggle()
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView(networkManager: NetworkManager(), showAddScreen: .constant(false), showListScreen: .constant(false), action: "POST", width: 300, height: 400)
    }
}

enum NetworkAction {
    case post
    case get
    case delete
    case update
    
    var image: Image {
        switch self {
        case .post:
           return Image(systemName: "doc.plaintext")
        case .get:
           return Image(systemName: "arrow.down.doc")
        case .delete:
           return Image(systemName: "trash.fill")
        case .update:
           return Image(systemName: "doc.richtext")
        }
    }
    
    var title: String {
        switch self {
        case .post:
            return "Post"
        case .get:
            return "Get"
        case .delete:
            return "Delete"
        case .update:
            return "Update"
        }
    }
    
    var accentColor: Color {
        switch self {
        case .post:
            return .blue
        case .get:
            return .indigo
        case .delete:
            return .red
        case .update:
            return .purple
        }
    }
    
    
}
