//
//  Image.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI

struct ImageVista: View {
    var body: some View {
        VStack {
            Image("youtubePDF")
                .renderingMode(.template) // para poder manipular la imagen y cambiar el color
                .resizable() //vamos a redimensionar la vista (se agranda a todo el espacio posible de la pantalla)
                .scaledToFit() //se ajusta al ancho del frame (deben de ir estos dos)
                .frame(width: 100, height: 100)
                .foregroundStyle(.cyan)
            
            Image("youtubePDF")
                .resizable(resizingMode: .tile) //patron,
        }
    }
}

#Preview {
    ImageVista()
}
