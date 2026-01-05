//
//  SwipeActionsAndRefreshable.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 03/01/26.
//

import SwiftUI

//MARK: SwipeActions Sirve para realizar acciones en una List deslizando a la derecha o a la izquierda
//MARK: Refreshable lo que hace es triggerear una acción cuando tiramos la lista hacia abajo
struct Devices {
    let title: String
    let iconSistemName: String
}

let devices: [Devices] = [
    .init(title: "iphone", iconSistemName: "iphone.gen1"),
    .init(title: "ipad", iconSistemName: "ipad.gen1"),
    .init(title: "mac", iconSistemName: "macbook"),
    .init(title: "watch", iconSistemName: "applewatch"),
    .init(title: "tv", iconSistemName: "appletv.fill"),
    .init(title: "headphones", iconSistemName: "airpods.max"),
    .init(title: "book", iconSistemName: "apple.books.pages.fill"),
]
struct SwipeActionsAndRefreshable: View {
    var body: some View {
        //MARK: Esta forma solamente es para mostrar una lista sencilla, no para hacer modificaciones como onDelete, onMove, para eso se necesita el ForEach
        /*List(devices, id: \.title) { device in
            Label(device.title, systemImage: device.iconSistemName)
        }*/
        NavigationStack {
            List {
                ForEach(devices, id: \.title) { device in
                    Label(device.title, systemImage: device.iconSistemName)
                        .swipeActions { // por defecto es trailing
                            Button("Favorito", systemImage: "star.fill") {
                                print("Favorito")
                            }
                            .tint(.green)
                            Button("Información", systemImage: "info.triangle.fill") {
                                print("Favorito")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading) {
                            Button("Borrar", systemImage: "trash.fill") {
                                print("Borrar")
                            }
                            .tint(.red)
                        }
                }
            }
            .navigationTitle("Dispositivos")
            .refreshable {
                print("Recargar información")
            }
        }
    }
}

#Preview {
    SwipeActionsAndRefreshable()
}
