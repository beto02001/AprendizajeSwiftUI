//
//  LinkVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct LinkVista: View {
    var body: some View {
        Link("Abre Youtube", destination: URL(string: "https://www.youtube.com")!)
            .padding()
            .foregroundStyle(.white)
            .background(.red)
            .cornerRadius(10)
            .font(.title2)
        
        Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
            Label("Abrir configuraciones", systemImage: "gearshape")
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .background(.blue)
                .cornerRadius(10)
        }
        
    }
}

#Preview {
    LinkVista()
}
