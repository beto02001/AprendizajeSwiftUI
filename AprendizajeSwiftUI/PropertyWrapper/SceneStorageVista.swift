//
//  SceneStorage.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 03/01/26.
//

import SwiftUI

//MARK: Sirve para guardar el estado de la app.
//MARK: Cada escena tiene su storage, NO se puede compartir entre varias escenas
//MARK: Si el user cierra la app, el propertiy Wraper @SceneStorage no persiste su valor, lo destruye
struct SceneStorageVista: View {
    
    //MARK: @State -> en memoria
    //MARK: @SceneStorage -> persistencia
    //@State var message: String = ""
    @SceneStorage("tweet") var message: String = ""
    
    @SceneStorage("toggle_publish") var sendHour: Bool = false
 
    var body: some View {
        Form {
            TextEditor(text: $message)
                .frame(height: 300)
            Toggle("Publicar a la mejor hora.", isOn: $sendHour)
            Button(sendHour ? "Publicar a la mejor hora" : "Publicar ahora") { }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    SceneStorageVista()
}
