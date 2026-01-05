//
//  AppStorageVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 02/01/26.
//

import SwiftUI

//MARK: Usar AppStorage usa por debajo UserDefault, sirve para persistir datos
struct AppStorageVista: View {
    
    //MARK: @State se guarda en memoria, cada vez que se vuelve a ejecutar la app, se crea una nueva instancia con los valores por defecto
    @State var usuario: String = ""
    
    //MARK: Para persistir datos se pcupa @AppStorage.
    //MARK: Se necesita una llave para identificar el valor por si en otra parte de la app queremos volver a esta información.
    @AppStorage("appStorageUsuario") var storageName: String = ""
    
    var body: some View {
        Form {
            TextField("Ingresa usuario", text: $usuario)
                
            HStack {
                Spacer()
                Button("Guardar") {
                    storageName = usuario
                }
                .buttonStyle(.borderedProminent)
                .padding()
                Spacer()
            }
        }
        .onAppear {
            usuario = storageName
        }
    }
}

#Preview {
    AppStorageVista()
}
