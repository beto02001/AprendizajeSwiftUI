//
//  ToggleVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct ToggleVista: View {
    @State var isOn: Bool = false
    
    var body: some View {
        Form {
            Toggle("Suscribete", isOn: $isOn)
            Text("Estado: \(isOn.description)")
                .bold()
        }
    }
}

#Preview {
    ToggleVista()
}
