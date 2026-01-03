//
//  NavigationVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 31/12/25.
//

import SwiftUI

struct NavigationVista: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Ir a menu", destination: {
                    Text("menu")
                })
                
                NavigationLink("ir a Desayunos") {
                    VStack {
                        Text("Desayunos")
                        Button("Pedir Desayuno") {
                            print("Creando...")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Text("Comidas")
                Text("Cenas")
            }
            .navigationBarItems(trailing: Button("Done", action: {
                print("Se presiona Done")
            }))
            .navigationTitle("Resturante")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(false)
            //.navigationBarTitleDisplayMode(.inline) // Titulo centrado en medio y chiquito
        }
    }
}

#Preview {
    NavigationVista()
}
