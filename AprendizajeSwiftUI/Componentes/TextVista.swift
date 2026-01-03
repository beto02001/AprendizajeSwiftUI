//
//  TextVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI

struct TextVista: View {
    var body: some View {
        VStack {
            Text("Este es un mensaje largo para poder representar cambios y manejo de texto que podria ser complicado")
                .font(.largeTitle)
                .underline()
                .rotation3DEffect(.degrees(30), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .gray, radius: 10, x: 0, y: 10)
                .lineLimit(10)
                .lineSpacing(10)
                .padding()
            
            //MARK: También se puede concatenar los text
            Text("Otro texto")
                .font(Font.largeTitle.italic())
            + Text("Otro texto")
                .foregroundColor(.accentColor)
            + Text(" Fin texto")
                .underline()
                .font(.title3)
            
            //MARK: Formateo de fechas
            Text(Date(), style: .date)
            Text(Date(), style: .time)
            Text(Date(), style: .timer) //Contador incrementar
            Text(Date().addingTimeInterval(61), style: .timer) // Decrementa, temporizador
        }
    }
}

#Preview {
    TextVista()
}
