//
//  StacksRotationText.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI

struct StacksRotationText: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Siguiendo")
                    .font(.largeTitle)
                    .bold()
                Text("Canales recomendados")
                    .textCase(Text.Case.uppercase)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                HStack {
                    Rectangle()
                        .frame(width: 120, height: 70)
                        .foregroundStyle(.blue)
                        .cornerRadius(5)
                    VStack(alignment: .leading) {
                        Label("Username", systemImage: "circle.fill")
                            .bold()
                        Text("Streaming de programación")
                        Text("123 seguidores")
                    }
                }
            }
            Text("Suscribete maldito!")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.red)
                .underline(true)
                .background(.black)
                .rotationEffect(.degrees(-25))
                
        }
    }
}

#Preview {
    StacksRotationText()
}
