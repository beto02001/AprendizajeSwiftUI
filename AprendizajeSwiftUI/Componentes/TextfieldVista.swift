//
//  TextfieldVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct TextfieldVista: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        //MARK: "$ valor proyectado, sirve para mandar el valor State a otra vista"
        VStack {
            TextField("Username", text: $username)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                .padding(10)
                .font(.headline)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            //.padding(.horizontal, 40)
            //.padding(.vertical, 20)
            //MARK: Para obtener cambios de escritura
                .onChange(of: username) { newValue in
                    print("Valor nuevo: \(newValue)")
                }
            
            SecureField("Password", text: $password)
                .keyboardType(.alphabet)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .padding(10)
                .font(.headline)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: password) { newValue in
                    print("Valor nuevo password: \(newValue)")
                }
            
            Spacer()
        }
        .padding(40)
    }
}

#Preview {
    TextfieldVista()
}
