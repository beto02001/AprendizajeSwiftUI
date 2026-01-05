//
//  AlertVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 01/01/26.
//

import SwiftUI

struct AlertVista: View {
    @State var isPresented: Bool = false
    var body: some View {
        VStack {
            Text("Presiona el boton")
            Button("Presionar") {
                print("Presionado")
                isPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
        /*.alert(isPresented: $isPresented) { //este ya está deprecado
            Alert(title: Text("Titulo de la alerta"), message: Text("esto es un mensaje para la alerta"), primaryButton: .default(Text("Aceptar"), action: {
                print("Boton primario")
            }), secondaryButton: .destructive(Text("Cancelar")))
        }*/
        .alert("tITULO DE LA ALERTA", isPresented: $isPresented) { //este es forma nueva
            Button("Aceptar") { print("Botón Aceptar") }
            Button("Cancelar", role: .cancel) { print("Botón Cancelar") }
        } message: {
            Text("Mensaje de la alerta")
        }
    }
}

#Preview {
    AlertVista()
}
