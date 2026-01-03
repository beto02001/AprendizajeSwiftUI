//
//  ObservedAndStateObject.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 02/01/26.
//

import SwiftUI
import Combine

struct ObservedAndStateObject: View {
    @State var contador: Int = 0
    var body: some View {
        VStack {
            Text("Valor de contador = \(contador)")
                .font(.largeTitle)
                .bold()
            Button("Incrementar valor") {
                contador += 1
            }
            Divider()
            Spacer()
            ListAprendizajeSwift()
        }
    }
}

struct ListAprendizajeSwift: View {
    //MARK: Sirve para estar escuchando todos los cambios que se generen en la clase instanciada
    //MARK: ¡¡¡IMPORTANTE!!! @ObservedObject escucha los cambios de la clase, pero si se redibuja el body de la clase padre, todos los cambios o EL ESTADO de la clase se pierde, para eso ocuparemos @StateObject
    ///  @ObservedObject var cursosViewModel: CursosViewModel = CursosViewModel()
    
    //MARK: ¿cUÁNDO OCUPAR @StateObject Y @ObservedObject?
    //MARK: Si es la primera vez que se ocupa el VM, se utilizará @StateObject
    //MARK: Si este VM se pasa a una subvista, ocuparemos @ObservedObject
    @StateObject var cursosViewModel: CursosViewModel = CursosViewModel()
    
    var body: some View {
        NavigationView {
            List(cursosViewModel.cursosModel, id: \.self) { curso in
                Text(curso)
                
            }
            .navigationBarItems(leading: Button("Añadir", action: { cursosViewModel.addMore() }))
            .navigationTitle(Text("Observables y StateObjects"))
        }
    }
}

final class CursosViewModel: ObservableObject {
    //MARK: Published es muy parecido a State pero este se ocupa en una clase.
    //MARK: @Published -> CLASE
    //MARK: @State -> STRUCT
    @Published var cursosModel: [String] = []
    
    init() {
        cursosModel = ["Aprender SwiftUI", "Aprender SwiftUI 2", "Aprender SwiftUI 3"]
    }
    
    func addMore() {
        cursosModel.append("Aprende CI/CD")
        cursosModel.append("Aprende Testing")
    }
}


#Preview {
    ObservedAndStateObject()
}
