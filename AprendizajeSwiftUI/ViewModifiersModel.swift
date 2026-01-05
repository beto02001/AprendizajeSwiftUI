//
//  ViewModifiersModel.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import Foundation
import SwiftUI

let modifiers: [Archives] = [
    .init(view: AnyView(ActionSheetVista()), name: "ActionSheet", code: """
        struct ActionSheetVista: View {
            @State private var showActionSheet: Bool = false
            var body: some View {
                VStack {
                    Text("Hello, World!")
                    Button("Puchalo") {
                        showActionSheet = true
                    }
                }
                //MARK: Esta forma ya esta deprecada
                /*.actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("ESTE ES EL TITULO"), message: Text("Este es el mensaje de la action sheet"), buttons: [.default(Text("Aceptar")), .cancel(),  .destructive(Text("Eliminar"))])
                }*/
                
                .confirmationDialog("Este es el titulo", isPresented: $showActionSheet, titleVisibility: .visible) {
                    Button("Aceptar") { }
                    Button("Cancelar 2", role: .cancel) { }
                    Button("Eliminar", role: .destructive) { }
                }
            }
        }
        """),
    .init(view: AnyView(AlertVista()), name: "Alert", code: """
        struct AlertVista: View {
            @State var isPresented: Bool = false
            var body: some View {
                VStack {
                    Text("Presiona el boton")
                    Button("Presionar") {
                        print("Presionado")
                        isPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                /*.alert(isPresented: $isPresented) { //este ya está deprecado
                    Alert(title: Text("Titulo de la alerta"), message: Text("esto es un mensaje para la alerta"), primaryButton: .default(Text("Aceptar"), action: {
                        print("Boton primario")
                    }), secondaryButton: .destructive(Text("Cancelar")))
                }*/
                .alert("tITULO DE LA ALERTA", isPresented: $isPresented) { //este es forma nueva
                    Button("Aceptar") { print("Botón Aceptar") }
                    Button("Cancelar", role: .cancel) { print("Botón Cancelar") }
                } message: {
                    Text("Mensaje de la alerta")
                }
            }
        }
        """),
    .init(view: AnyView(ContextMenuVista()), name: "ContextMenu", code: """
        //MARK: SIRVE PARA QUE APAREZCA UN MENU CON OPCIONES EN FORMA DE POP UP al mantener pulsado
        struct ContextMenuVista: View {
            var body: some View {
                Text("Hello, World!")
                    .contextMenu {
                        Button("SwiftUI") {
                            print("SWIFTui")
                        }
                        Button("Xcode") {
                            print("Xcode")
                        }
                        Button {
                            print("MacOS")
                        } label: {
                            Label("Utiliza mac", systemImage: "laptopcomputer.and.iphone")
                        }

                    }
            }
        }
        """),
    .init(view: AnyView(DragGestureVista()), name: "Drag Gesture", code: """
        struct DragGestureVista: View {
            @State var position: CGSize = .zero
            
            var body: some View {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
                    .overlay(Text("Drag me").bold().foregroundStyle(.white))
                    .offset(position)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                position = value.translation
                            })
                            .onEnded { _ in
                                withAnimation(.spring) {
                                    position = .zero
                                }
                            }
                            
                    )
            }
        }
        """),
    .init(view: AnyView(SheetVista()), name: "Sheet", code: """
        struct SheetVista: View {
            @State var isPresented: Bool = false
            var body: some View {
                VStack {
                    Text("Vista 1")
                    Button("boton ok") {
                        isPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                        
                }
                //MARK: Para ocupar toda la pantalla es con ".fullScreenCover"" mismo inicializador que el sheet
                .sheet(isPresented: $isPresented) {
                    //MARK: Dentro del closure onDismiss, sirve para poner las instrucciones que queramos que cuando se oculte la pantalla se ejecuten instrucciones
                    isPresented = false
                } content: {
                    //MARK: Aquí se especifica qué vista aparecerá
                    ZStack {
                        Color.red.ignoresSafeArea()
                        Button("Pulsa el boton") {
                            isPresented = false
                        }
                    }
                }

            }
        }
        """),
    .init(view: AnyView(SwipeActionsAndRefreshable()), name: "Swipe actions and refreshable", code: """
        
        //MARK: SwipeActions Sirve para realizar acciones en una List deslizando a la derecha o a la izquierda
        //MARK: Refreshable lo que hace es triggerear una acción cuando tiramos la lista hacia abajo
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
                /*List(devices, id: \\.title) { device in
                    Label(device.title, systemImage: device.iconSistemName)
                }*/
                NavigationStack {
                    List {
                        ForEach(devices, id: \\.title) { device in
                            Label(device.title, systemImage: device.iconSistemName)
                                .swipeActions { // por defecto es trailing
                                    Button("Favorito", systemImage: "star.fill") {
                                        print("Favorito")
                                    }
                                    .tint(.green)
                                    Button("Información", systemImage: "info.triangle.fill") {
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
                        print("Recargar información")
                    }
                }
            }
        }
        """),
    .init(view: AnyView(TapGestureVista()), name: "Tap gesture", code: """
        struct TapGestureVista: View {

            @State var counter: Int = 0
            
            //MARK: Opcioón 2
            var doubleTapGesture: some Gesture {
                TapGesture()
                    .onEnded { counter += 2 }
            }
            
            var body: some View {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.indigo)
                    //MARK: Opcioón 1
                    /*.gesture(
                        TapGesture()
                            .onEnded({ _ in
                                counter += 1
                            })
                    )*/
                
                    //MARK: Opcioón 2
                    //.gesture(doubleTapGesture)
                
                    //MARK: Opcioón 3 la más fácil de hacer
                    .onTapGesture {
                        counter += 3
                    }
                Text("\\(counter) taps")
            }
        }
        """),
    .init(view: AnyView(ViewModifierVista()), name: "ViewModifier", code: """
        //MARK: Opción - Struct
        struct PersonalButtonModifier: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .buttonStyle(.borderedProminent)
                    .font(.title)
                    .bold()
                    .tint(.green)
            }
        }

        //MARK: Opción 2 - Extension para crear el modificador
        extension View {
            func  newButton() -> some View {
                self.modifier(PersonalButtonModifier())
            }
        }

        struct ViewModifierVista: View {
            var body: some View {
                Button("Un boton") {
                    //todo
                }
                //.modifier(PersonalButtonModifier())
                .newButton()
            }
        }
        """)
    
]
