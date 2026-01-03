//
//  StepperVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct StepperVista: View {
    @State var celCounter = 1
    var body: some View {
        Form {
            Stepper("Celular \(celCounter)", value: $celCounter, in: 1...4, step: 2)
                .padding(.vertical)
            Stepper("Celular - \(celCounter)") {
                celCounter += 1
            } onDecrement: {
                celCounter -= 1
            }
            .padding(.vertical)

        }
    }
}

#Preview {
    StepperVista()
}
