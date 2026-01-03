//
//  ProgressVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct ProgressVista: View {
    @State var isLoading = false
    @State var progress: Float = 0.0
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("1.- Cargando...")
                    //.scaleEffect(2)
            }
            ProgressView(value: progress)
            
            Button("Cargando") {
                isLoading.toggle()
                progress += 0.1
            }
            .padding()
        }
    }
}

#Preview {
    ProgressVista()
}
