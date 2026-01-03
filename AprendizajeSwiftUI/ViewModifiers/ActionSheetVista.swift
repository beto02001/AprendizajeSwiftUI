//
//  ActionSheetVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 01/01/26.
//

import SwiftUI

struct ActionSheetVista: View {
    @State private var showActionSheet: Bool = false
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("Puchalo") {
                showActionSheet = true
            }
        }
        //MARK: Esta forma ya esta deprecada
        /*.actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("ESTE ES EL TITULO"), message: Text("Este es el mensaje de la action sheet"), buttons: [.default(Text("Aceptar")), .cancel(),  .destructive(Text("Eliminar"))])
        }*/
        
        .confirmationDialog("Este es el titulo", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Aceptar") { }
            Button("Cancelar 2", role: .cancel) { }
            Button("Eliminar", role: .destructive) { }
        }
    }
}

#Preview {
    ActionSheetVista()
}
