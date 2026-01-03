//
//  ContextMenuVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 01/01/26.
//

import SwiftUI

//MARK: SIRVE PARA QUE APAREZCA UN MENU CON OPCIONES EN FORMA DE POP UP al mantener pulsado
struct ContextMenuVista: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .contextMenu {
                Button("SwiftUI") {
                    print("SWIFTui")
                }
                Button("Xcode") {
                    print("Xcode")
                }
                Button {
                    print("MacOS")
                } label: {
                    Label("Utiliza mac", systemImage: "laptopcomputer.and.iphone")
                }

            }
    }
}

#Preview {
    ContextMenuVista()
}
