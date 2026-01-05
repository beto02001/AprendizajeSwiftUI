//
//  ComponentsModel.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import Foundation
import SwiftUI

struct Archives {
    let view: AnyView
    let name: String
    let code: String
}

let componentes: [Archives] = [
    .init(view: AnyView(ButtonVista()), name: "Boton",
          code: """
        struct ButtonVista: View {
            var body: some View {
                VStack(spacing: 50) {
                    Button("Suscribete") {
                        print("Suscrito")
                    }
                    .foregroundColor(.white)
                    .font(.title)
                    .textCase(.uppercase)
                    .bold()
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
                    .shadow(radius: 10, y: 10)
                }
                
                Button {
                    print("Le dio like al video")
                } label: {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .shadow(radius: 10, y: 10)
                        .overlay { //poner elementos sobre otro
                            Image(systemName: "hand.thumbsup.fill")
                                //.renderingMode(.template)
                                //.resizable()
                                //.frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .font(.system(size: 50, weight: .bold))
                                
                        }
                }
            }
        }
        """),
    .init(view: AnyView(DatePickerVista()), name: "DatePicker", code: """
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
        """),
    .init(view: AnyView(FormVista()), name: "Form", code: """
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
        """),
    .init(view: AnyView(ImageVista()), name: "Image", code: """
        struct ImageVista: View {
            var body: some View {
                VStack {
                    Image("youtubePDF")
                        .renderingMode(.template) // para poder manipular la imagen y cambiar el color
                        .resizable() //vamos a redimensionar la vista (se agranda a todo el espacio posible de la pantalla)
                        .scaledToFit() //se ajusta al ancho del frame (deben de ir estos dos)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.cyan)
                    
                    Image("youtubePDF")
                        .resizable(resizingMode: .tile) //patron,
                }
            }
        }
        """),
    .init(view: AnyView(LabelView()), name: "Label", code: """
        //MARK: Sirve para mostrar un icono y un texto en un mimo componente
        struct LabelView: View {
            var body: some View {
                Label("Este un mensaje en string", image: "youtubePDF")
                    .font(.largeTitle)
                    .labelStyle(.titleAndIcon) //esta propiedad sirve para priorizar qué se mostraría en caso de que no quepan los dos en pantalla
            }
        }
        """),
    .init(view: AnyView(LazyHGridVista()), name: "LazyHGrid", code: """
        struct LazyHGridVista: View {
            var body: some View {
                let items = 1...500
                let rows: [GridItem] = [.init(.fixed(100)),
                                        .init(.flexible(minimum: 10, maximum: 70)),
                                        .init(.fixed(100))]
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        ForEach(items, id: \\.self) { element in
                            VStack {
                                Circle()
                                    .frame( height: 50)
                                    .foregroundStyle(.blue)
                                Text("\\(element)")
                            }
                        }
                    }
                }
            }
        }
        """),
    .init(view: AnyView(LazyVGridVista()), name: "LazyVGrid", code: """
        struct LazyVGridVista: View {
            var body: some View {
                let elements = 1...500
                let gridItems: [GridItem] = [GridItem(.fixed(100)),
                                             GridItem(.adaptive(minimum: 30)),
                                             GridItem(.fixed(100))]
                ScrollView {
                    //MARK: Para ocupar las vista Lazy necesitamos el ScrollView para poder hacer scroll
                    LazyVGrid(columns: gridItems) {
                        ForEach(elements, id: \\.self) { element in
                            VStack {
                                Circle()
                                    .frame( height: 50)
                                    .foregroundStyle(.blue)
                                Text("\\(element)")
                            }
                        }
                    }
                }
            }
        }
        """),
    .init(view: AnyView(LinkVista()), name: "Link", code: """
        struct LinkVista: View {
            var body: some View {
                Link("Abre Youtube", destination: URL(string: "https://www.youtube.com")!)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
                    .cornerRadius(10)
                    .font(.title2)
                
                Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                    Label("Abrir configuraciones", systemImage: "gearshape")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                }
                
            }
        }
        """),
    .init(view: AnyView(NavigationVista()), name: "NavigationView", code: """
        struct NavigationVista: View {
            var body: some View {
                NavigationView {
                    List {
                        NavigationLink("Ir a menu", destination: {
                            Text("menu")
                        })
                        
                        NavigationLink("ir a Desayunos") {
                            VStack {
                                Text("Desayunos")
                                Button("Pedir Desayuno") {
                                    print("Creando...")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                        Text("Comidas")
                        Text("Cenas")
                    }
                    .navigationBarItems(trailing: Button("Done", action: {
                        print("Se presiona Done")
                    }))
                    .navigationTitle("Resturante")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarHidden(false)
                    //.navigationBarTitleDisplayMode(.inline) // Titulo centrado en medio y chiquito
                }
            }
        }
        """),
    .init(view: AnyView(ProgressVista()), name: "Progress", code: """
        struct ProgressVista: View {
            @State var isLoading = false
            @State var progress: Float = 0.0
            
            var body: some View {
                VStack {
                    if isLoading {
                        ProgressView("1.- Cargando...")
                            //.scaleEffect(2)
                    }
                    ProgressView(value: progress)
                    
                    Button("Cargando") {
                        isLoading.toggle()
                        progress += 0.1
                    }
                    .padding()
                }
            }
        }
        """),
    .init(view: AnyView(SliderVista()), name: "Slider", code: """
        struct SliderVista: View {
            @State var celCounter: Float = 0.0
            @State var isEditing = false
            var body: some View {
                Form {
                    Slider(value: $celCounter, in: 0...10, step: 1) {
                        Text("Selecciona numero de celulares")
                    } minimumValueLabel: {
                        Text("min")
                    } maximumValueLabel: {
                        Text("max")
                    } onEditingChanged: { editing in
                        isEditing = editing
                    }
                    HStack {
                        Spacer()
                        Text(celCounter.description)
                            .foregroundStyle(isEditing ? .green : .secondary)
                            .bold()
                        Spacer()
                    }
                        
                }
            }
        }
        """),
    .init(view: AnyView(StacksRotationText()), name: "VStack yZStack", code: """
        struct StacksRotationText: View {
            var body: some View {
                ZStack {
                    VStack(alignment: .leading) {
                        Text("Siguiendo")
                            .font(.largeTitle)
                            .bold()
                        Text("Canales recomendados")
                            .textCase(Text.Case.uppercase)
                            .font(.subheadline)
                            .foregroundStyle(Color.secondary)
                        HStack {
                            Rectangle()
                                .frame(width: 120, height: 70)
                                .foregroundStyle(.blue)
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Label("Username", systemImage: "circle.fill")
                                    .bold()
                                Text("Streaming de programación")
                                Text("123 seguidores")
                            }
                        }
                    }
                    Text("Suscribete maldito!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.red)
                        .underline(true)
                        .background(.black)
                        .rotationEffect(.degrees(-25))
                        
                }
            }
        }
        """),
    .init(view: AnyView(StepperVista()), name: "Stepper", code: """
        struct StepperVista: View {
            @State var celCounter = 1
            var body: some View {
                Form {
                    Stepper("Celular \\(celCounter)", value: $celCounter, in: 1...4, step: 2)
                        .padding(.vertical)
                    Stepper("Celular - \\(celCounter)") {
                        celCounter += 1
                    } onDecrement: {
                        celCounter -= 1
                    }
                    .padding(.vertical)

                }
            }
        }
        """),
    .init(view: AnyView(TabVista()), name: "TabView y carrusel", code: """
        import SwiftUI

        struct TabVista: View {
            var body: some View {
                VStack {
                    CarruselView()
                        .frame(height: 400)
                        .tabViewStyle(.page)
                    
                    TabView {
                        HomeView()
                            .tabItem { // esta forma esta por deprecarse
                                Image(systemName: "house.fill")
                                Text("Inicio")
                            }
                        
                        ProfileView()
                            .tabItem {
                                Label("Perfil label", systemImage: "person.fill")
                            }
                        
                        //Esta es la nueva forma para ios 18
                        /*Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
                         Circle()
                         }*/
                    }
                    .accentColor(.green)
                }
            }
        }

        struct CarruselView: View {
            var body: some View {
                TabView {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .padding(10)
                        .foregroundStyle(.blue)
                    
                    RoundedRectangle(cornerRadius: 20, style: .circular)
                        .padding(10)
                        .foregroundStyle(.red)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .padding(10)
                        .foregroundStyle(.orange)
                    
                }
            }
        }

        struct HomeView: View {
            var body: some View {
                VStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Inicio")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }

        struct ProfileView: View {
            var body: some View {
                Text("Vista que se verá en profile")
            }
        }
        """),
    .init(view: AnyView(TextEditorVista()), name: "TextEditor", code: """
        struct TextEditorVista: View {
            @State var text = ""
            @State var counter = 0
            var body: some View {
                VStack {
                    TextEditor(text: $text)
                        .font(.title)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.blue)
                        .padding()
                        .background(.red)
                        .onChange(of: text) { newValue in
                            counter = newValue.count
                        }
                    
                    Text("\\(counter)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(counter <= 280 ? .green : . orange)
                }
            }
        }
        """),
    .init(view: AnyView(TextfieldVista()), name: "Textfield", code: """
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
                            print("Valor nuevo: \\(newValue)")
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
                            print("Valor nuevo password: \\(newValue)")
                        }
                    
                    Spacer()
                }
                .padding(40)
            }
        }
        """),
    .init(view: AnyView(TextVista()), name: "Text", code: """
        struct TextVista: View {
            var body: some View {
                VStack {
                    Text("Este es un mensaje largo para poder representar cambios y manejo de texto")
                        .font(.largeTitle)
                        .underline()
                        .rotation3DEffect(.degrees(30), axis: (x: 1, y: 0, z: 0))
                        .shadow(color: .gray, radius: 10, x: 0, y: 10)
                        .lineLimit(10)
                        .lineSpacing(10)
                        .padding()
                    
                    //MARK: También se puede concatenar los text
                    Text("Otro texto")
                        .font(Font.largeTitle.italic())
                    + Text("Otro texto")
                        .foregroundColor(.accentColor)
                    + Text(" Fin texto")
                        .underline()
                        .font(.title3)
                    
                    //MARK: Formateo de fechas
                    Text(Date(), style: .date)
                    Text(Date(), style: .time)
                    Text(Date(), style: .timer) //Contador incrementar
                    Text(Date().addingTimeInterval(61), style: .timer) // Decrementa, temporizador
                }
            }
        }
        """),
    .init(view: AnyView(ToggleVista()), name: "Toggle", code: """
        struct ToggleVista: View {
            @State var isOn: Bool = false
            
            var body: some View {
                Form {
                    Toggle("Suscribete", isOn: $isOn)
                    Text("Estado: \\(isOn.description)")
                        .bold()
                }
            }
        }
        """),
]

