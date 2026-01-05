//
//  ViewModifierVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import SwiftUI

//MARK: Opción - Struct
struct PersonalButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .font(.title)
            .bold()
            .tint(.green)
    }
}

//MARK: Opción 2 - Extension para crear el modificador
extension View {
    func  newButton() -> some View {
        self.modifier(PersonalButtonModifier())
    }
}

struct ViewModifierVista: View {
    var body: some View {
        Button("Un boton") {
            //todo
        }
        //.modifier(PersonalButtonModifier())
        .newButton()
    }
}

#Preview {
    ViewModifierVista()
}
