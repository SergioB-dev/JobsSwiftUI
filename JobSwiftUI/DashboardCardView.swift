//
//  DashboardCardView.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/4/21.
//

import SwiftUI

struct DashboardCardView: View {
    let key: String
    let value: String
    let index: Int
    let color: Color
    
    var body: some View {
        ZStack {
            Color.red
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 3))
                
            VStack {
                Text(key).bold()
                    .font(.caption)
                    .padding(.top, 5)
                Text(value)
                Spacer()
            }
        }.frame(width: 80, height: 100)
            .cornerRadius(10)
    }
}

struct DashboardCardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardCardView(key: "Salary", value: "$157k", index: 0, color: .red)
    }
}
