//
//  BindingPropertyWrappper.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 02/01/26.
//

import SwiftUI

struct BindingPropertyWrappper: View {
    //MARK: Como la variable en estructuras son de tipo valor e inmutables, necesitamos el @State para poder mutar o cambiar el valor
    //MARK: Se delegará la mutabilidad de la propiedad a otra vista para que esa vista modifique el valor del @State
    @State var counter = 0
    
    var body: some View {
        CounterView(counter: $counter)
    }
}

struct CounterView: View {
    //MARK: -- Usas @Binding cuando tengas que mutar una proiedad @State que viene de otra vista --
    // MARK: @Binding permite recibir una referencia a un estado que pertenece a otra vista.
    // MARK: Esta vista NO es dueña del valor, solo lo lee y lo modifica.
    // MARK: Cualquier cambio hecho aquí se refleja inmediatamente en la vista padre que declaró el @State original.
    /*
     BindingPropertyWrapper
     └── @State counter
          └── $counter → CounterView
                         └── @Binding counter

     */
    @Binding var counter: Int
    var body: some View {
        Text("Valor de contador = \(counter)")
        Button("Incrementar valor") {
            counter += 1
        }
    }
}
#Preview {
    BindingPropertyWrappper()
}
