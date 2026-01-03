//
//  DatePickerVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct DatePickerVista: View {
    @State var currentDate = Date()
    var body: some View {
        Form {
            //MARK: Este en especifico sirve para seleccionar dias futuros al de hoy
            DatePicker("Fecha", selection: $currentDate, in: Date()..., displayedComponents: .hourAndMinute)
            Text(currentDate, style: .time)
                .bold()
        }
    }
}

#Preview {
    DatePickerVista()
}
