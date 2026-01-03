//
//  StatePropertyWrapper.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI

struct StatePropertyWrapper: View {
    //MARK: Como la variable en estructuras son de tipo valor e inmutables, necesitamos el @State para poder mutar o cambiar el valor
    //MARK: Cuando cambia de valor una variable state, la variable body se vuelve actualizar, la vista actualiza su estado
    @State var counter = 0
    
    var body: some View {
        Text("Valor de contador = \(counter)")
        Button("Incrementar valor") {
            //todo
            counter += 1
        }
    }
}

#Preview {
    StatePropertyWrapper()
}
