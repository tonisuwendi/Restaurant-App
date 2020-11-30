//
//  AboutView.swift
//  Restoranku
//
//  Created by mac on 26/11/20.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        ZStack {
            ScrollView {
                Image("toni")
                    .resizable()
                    .cornerRadius(75)
                    .frame(width: 150, height: 150)
                    .padding(.top, 50)
                Text("Toni Suwendi")
                    .padding(.top)
                    .font(.title)
                Text("tonisuwen@gmail.com")
                    .font(.title3)
            }
        }
        .navigationBarTitle(Text("About Me"), displayMode: .inline)
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
