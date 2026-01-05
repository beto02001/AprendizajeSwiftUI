//
//  EnvironmentObjectVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 02/01/26.
//

import SwiftUI
import Combine

final class ViewModelEnvironmentObject: ObservableObject {
    @Published var counter = 0
}

struct EnvironmentObjectVista: View {
    // MARK: @StateObject se usa para CREAR y POSEER un ViewModel dentro de una vista.
    // MARK: Esta vista es la responsable del ciclo de vida del ViewModel.
    // MARK: SwiftUI garantiza que el objeto se crea UNA sola vez
    // MARK: y se mantiene vivo aunque la vista se vuelva a renderizar.
    // MARK: Se usa cuando esta vista es el "origen" del estado.
    @StateObject var viewModel = ViewModelEnvironmentObject()

    var body: some View {
        VStack {
            Text("Vista 1")
            Text("\(viewModel.counter)")
            Vista2()
        }
        .padding()
        .border(.green)

        // MARK: environmentObject inyecta el ViewModel en el entorno de SwiftUI.
        // MARK: Todas las vistas hijas (Vista2, Vista3, etc.)
        // MARK: pueden acceder a este ViewModel sin recibirlo por inicializador.
        // MARK: Se usa cuando múltiples vistas necesitan compartir el mismo estado.
        .environmentObject(viewModel)
    }
}

struct Vista2: View {
    var body: some View {
        VStack {
            Text("Vista 2")
            Vista3()
        }
        .padding()
        .border(.orange)
    }
}

struct Vista3: View {

    // MARK: @EnvironmentObject permite acceder a un objeto compartido que fue inyectado previamente en el entorno de SwiftUI.
    // MARK: Esta vista NO crea ni posee el ViewModel.
    // MARK: El objeto debe existir en una vista padre usando .environmentObject(...).
    // MARK: Se usa cuando la vista necesita leer o modificar un estado global o compartido entre varias vistas.
    @EnvironmentObject var viewModel: ViewModelEnvironmentObject

    var body: some View {
        VStack {
            Text("Vista 3")
            Button("Aumentar contador") {
                viewModel.counter += 1
            }
        }
        .padding()
        .border(.blue)
    }
}

#Preview {
    EnvironmentObjectVista()
}
