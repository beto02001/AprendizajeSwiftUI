//
//  LabelView.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI

//MARK: Sirve para mostrar un icono y un texto en un mimo componente
struct LabelView: View {
    var body: some View {
        Label("Este un mensaje en string", image: "youtubePDF")
            .font(.largeTitle)
            .labelStyle(.titleAndIcon) //esta propiedad sirve para priorizar qué se mostraría en caso de que no quepan los dos en pantalla
    }
}

#Preview {
    LabelView()
}
