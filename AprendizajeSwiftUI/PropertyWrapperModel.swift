//
//  PropertyWrapperModel.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import Foundation
import SwiftUI

let propertys: [Archives] = [
    .init(view: AnyView(AppStorageVista()), name: "AppStorage", code: """
        //MARK: Usar AppStorage usa por debajo UserDefault, sirve para persistir datos
        struct AppStorageVista: View {
            
            //MARK: @State se guarda en memoria, cada vez que se vuelve a ejecutar la app, se crea una nueva instancia con los valores por defecto
            @State var usuario: String = ""
            
            //MARK: Para persistir datos se pcupa @AppStorage.
            //MARK: Se necesita una llave para identificar el valor por si en otra parte de la app queremos volver a esta información.
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
        """),
    .init(view: AnyView(BindingPropertyWrappper()), name: "Binding", code: """
        struct BindingPropertyWrappper: View {
            //MARK: Como la variable en estructuras son de tipo valor e inmutables, necesitamos el @State para poder mutar o cambiar el valor
            //MARK: Se delegará la mutabilidad de la propiedad a otra vista para que esa vista modifique el valor del @State
            @State var counter = 0
            
            var body: some View {
                CounterView(counter: $counter)
            }
        }

        struct CounterView: View {
            //MARK: -- Usas @Binding cuando tengas que mutar una proiedad @State que viene de otra vista --
            // MARK: @Binding permite recibir una referencia a un estado que pertenece a otra vista.
            // MARK: Esta vista NO es dueña del valor, solo lo lee y lo modifica.
            // MARK: Cualquier cambio hecho aquí se refleja inmediatamente en la vista padre que declaró el @State original.
            /*
             BindingPropertyWrapper
             └── @State counter
                  └── $counter → CounterView
                                 └── @Binding counter
             */
            @Binding var counter: Int
            var body: some View {
                Text("Valor de contador = \\(counter)")
                Button("Incrementar valor") {
                    counter += 1
                }
            }
        }
        """),
    .init(view: AnyView(EnvironmentObjectVista()), name: "EnviromentObject", code: """
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
                    Text("\\(viewModel.counter)")
                    Vista2()
                }
                .padding()
                .border(.green)

                // MARK: environmentObject inyecta el ViewModel en el entorno de SwiftUI.
                // MARK: Todas las vistas hijas (Vista2, Vista3, etc.)
                // MARK: pueden acceder a este ViewModel sin recibirlo por inicializador.
                // MARK: Se usa cuando múltiples vistas necesitan compartir el mismo estado.
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
        """),
    .init(view: AnyView(ObservedAndStateObject()), name: "ObservedObject y StateObject", code: """
        import SwiftUI
        import Combine

        struct ObservedAndStateObject: View {
            @State var contador: Int = 0
            var body: some View {
                VStack {
                    Text("Valor de contador = \\(contador)")
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
            
            //MARK: ¿cUÁNDO OCUPAR @StateObject Y @ObservedObject?
            //MARK: Si es la primera vez que se ocupa el VM, se utilizará @StateObject
            //MARK: Si este VM se pasa a una subvista, ocuparemos @ObservedObject
            @StateObject var cursosViewModel: CursosViewModel = CursosViewModel()
            
            var body: some View {
                NavigationView {
                    List(cursosViewModel.cursosModel, id: \\.self) { curso in
                        Text(curso)
                    }
                    .navigationBarItems(leading: Button("Añadir", action: { cursosViewModel.addMore() }))
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
        """),
    .init(view: AnyView(ObservedAndStateObjectPropagation()), name: "Observed an State propagation", code: """
        import SwiftUI
        import Combine

        final class ViewModel: ObservableObject {
            @Published var counter = 0
        }

        struct ObservedAndStateObjectPropagation: View {
            @StateObject var viewModel = ViewModel()
            var body: some View {
                VStack {
                    Text("Vista 1")
                    Text("\\(viewModel.counter)")
                    View2(viewModel: viewModel)
                }
                .padding()
                .border(.green)
            }
        }

        struct View2: View {
            @ObservedObject var viewModel: ViewModel
            var body: some View {
                VStack {
                    Text("Vista 2")
                    View3(viewModel: viewModel)
                }
                .padding()
                .border(.orange)
            }
        }

        struct View3: View {
            @ObservedObject var viewModel: ViewModel
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
        """),
    .init(view: AnyView(SceneStorageVista()), name: "SceneStorage", code: """
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
        """),
    .init(view: AnyView(StatePropertyWrapper()), name: "State", code: """
        struct StatePropertyWrapper: View {
            //MARK: Como la variable en estructuras son de tipo valor e inmutables, necesitamos el @State para poder mutar o cambiar el valor
            //MARK: Cuando cambia de valor una variable state, la variable body se vuelve actualizar, la vista actualiza su estado
            @State var counter = 0
            
            var body: some View {
                Text("Valor de contador = \\(counter)")
                Button("Incrementar valor") {
                    //todo
                    counter += 1
                }
            }
        }
        """)
]
