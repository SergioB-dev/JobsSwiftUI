//
//  PositionSelectionView.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/4/21.
//

import SwiftUI

struct PositionSelectionView: View {
    @Binding var position: String
    var body: some View {
        HStack {
            ForEach(profiles, id: \.image) { image in
                Spacer()
                VStack {
                    Button(action:{ selectPosition(image.position)}) {
                        Image(image.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2)
                            )
                    }
                    Text(image.position)
                        .frame(width: 50)
                        .font(.caption)
                        .lineLimit(1)
                }
                        
                
                Spacer()
                   
                
            }
        }
    }
    struct Profile {
        let image: String
        let position: String
    }
    
    private func selectPosition(_ selection: String) {
        self.position = selection
    }
    
    private let profiles = [Profile(image: "babyBirdOrange", position: "Junior iOS Dev"), Profile(image: "fullStack", position: "Full Stack iOS Dev"), Profile(image: "senioriOSDev", position: "Senior iOS Dev"), Profile(image: "teamLeaderOrange", position: "Intern")]
}

struct PositionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PositionSelectionView(position: .constant(""))
    }
}
