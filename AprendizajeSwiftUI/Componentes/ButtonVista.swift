//
//  ButtonVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI

struct ButtonVista: View {
    var body: some View {
        VStack(spacing: 50) {
            Button("Suscribete") {
                print("Suscrito")
            }
            .foregroundColor(.white)
            .font(.title)
            .textCase(.uppercase)
            .bold()
            .padding()
            .background(.red)
            .cornerRadius(10)
            .shadow(radius: 10, y: 10)
        }
        
        Button {
            print("Le dio like al video")
        } label: {
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .shadow(radius: 10, y: 10)
                .overlay { //poner elementos sobre otro
                    Image(systemName: "hand.thumbsup.fill")
                        //.renderingMode(.template)
                        //.resizable()
                        //.frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 50, weight: .bold))
                        
                }
        }
    }
}

#Preview {
    ButtonVista()
}
