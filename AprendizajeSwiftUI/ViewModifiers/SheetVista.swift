//
//  SheetVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 31/12/25.
//

import SwiftUI

struct SheetVista: View {
    @State var isPresented: Bool = false
    var body: some View {
        VStack {
            Text("Vista 1")
            Button("boton ok") {
                isPresented = true
            }
            .buttonStyle(.borderedProminent)
                
        }
        //MARK: Para ocupar toda la pantalla es con ".fullScreenCover"" mismo inicializador que el sheet
        .sheet(isPresented: $isPresented) {
            //MARK: Dentro del closure onDismiss, sirve para poner las instrucciones que queramos que cuando se oculte la pantalla se ejecuten instrucciones
            isPresented = false
        } content: {
            //MARK: Aquí se especifica qué vista aparecerá
            ZStack {
                Color.red.ignoresSafeArea()
                Button("Pulsa el boton") {
                    isPresented = false
                }
            }
        }

    }
}

#Preview {
    SheetVista()
}
