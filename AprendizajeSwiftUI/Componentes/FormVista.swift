//
//  FormVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct FormVista: View {
    @State var isOn: Bool = false
    @State var volumen: Double = 0.5
    @State var phoneNumber: String = ""
    @State var birthday: Date = Date()
    var body: some View {
        Form {
            Section("Configuracion") {
                Toggle("Prender localización", isOn: $isOn)
                    .toggleStyle(.switch)
                Slider(value: $volumen, in: 0...1) {
                    Text("Volumen")
                } minimumValueLabel: {
                    Text("Min")
                } maximumValueLabel: {
                    Text("Max")
                }
            }

            Section {
                TextField("Numero de contacto", text: $phoneNumber)
                    .keyboardType(.namePhonePad)
                DatePicker("Cumpleaños", selection: $birthday, displayedComponents: .date)
            } header: {
                Label("Contactos", systemImage: "person.3.fill")
            } footer: {
                HStack {
                    Spacer()
                    Label("Version iOS 15", systemImage: "arrow.2.circlepath.circle")
                    Spacer()
                }
            }
            
        }
    }
}

#Preview {
    FormVista()
}
