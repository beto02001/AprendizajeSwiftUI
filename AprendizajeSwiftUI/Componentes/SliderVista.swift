//
//  SliderVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct SliderVista: View {
    @State var celCounter: Float = 0.0
    @State var isEditing = false
    var body: some View {
        Form {
            Slider(value: $celCounter, in: 0...10, step: 1) {
                Text("Selecciona numero de celulares")
            } minimumValueLabel: {
                Text("min")
            } maximumValueLabel: {
                Text("max")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            HStack {
                Spacer()
                Text(celCounter.description)
                    .foregroundStyle(isEditing ? .green : .secondary)
                    .bold()
                Spacer()
            }
                
        }
    }
}

#Preview {
    SliderVista()
}
