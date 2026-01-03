//
//  ListVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 30/12/25.
//

import SwiftUI

struct Device {
    var title: String
    let imageName: String
}

let houseDevises: [Device] = [
    .init(title: "Laptop", imageName: "laptop"),
    .init(title: "Mac mini", imageName: "macmini"),
    .init(title: "Mac pro", imageName: "macmini"),
    .init(title: "iPhone", imageName: "iphone"),
]

let workDevices: [Device] = [
    .init(title: "Mac", imageName: "macmini"),
    .init(title: "iPad", imageName: "ipad"),
    .init(title: "Airpods", imageName: "airpods")
]
struct ListVista: View {
    @State private var workExpanded = true
    
    var body: some View {
        //MARK: Para crear la forma del sidebar y que pueda colapsar se necesita como primero:
        ///  1.- Tener el navigationView
        ///  2.- Agregar un DisclosureGroup con isExpanded
        ///  ** Poner el .listStyle(.sidebar) no funciona, con el Disclosure aparece el colapso **
        NavigationView {
            List {
                Section {
                    ForEach(houseDevises, id: \.title) { device in
                        Label(device.title, systemImage: device.imageName)
                    }
                } header: {
                    Text("Home")
                }
                
                DisclosureGroup(isExpanded: $workExpanded) {
                    ForEach(workDevices, id: \.title) { device in
                        Label(device.title, systemImage: device.imageName)
                    }
                } label: {
                    Text("Dispositivos de trabajo")
                        .font(.headline)
                }
            }
            //.listStyle(.insetGrouped)
        }
    }
}

#Preview {
    ListVista()
}
