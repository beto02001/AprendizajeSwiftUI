//
//  ContentView.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 26/12/25.
//

import SwiftUI
struct ComponentDetailModifier: ViewModifier {
    let title: String
    let code: String

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Code") {
                        CodeView(code: code)
                    }
                }
            }
    }
}

// Extensión para usarlo de forma más natural (.withComponentDetails)
extension View {
    func withComponentDetails(title: String, code: String) -> some View {
        modifier(ComponentDetailModifier(title: title, code: code))
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                sectionFor(title: "Componentes", data: componentes)
                sectionFor(title: "Property Wrappers", data: propertys)
                sectionFor(title: "View Modifiers", data: modifiers)
            }
            .navigationTitle("Aprendizaje SwiftUI")
        }
    }

    // Helper para no repetir el ForEach
    @ViewBuilder
    func sectionFor(title: String, data: [Archives]) -> some View {
        Section(title) {
            ForEach(data, id: \.name) { componente in
                NavigationLink {
                    componente.view
                        .withComponentDetails(title: componente.name, code: componente.code)
                } label: {
                    Text(componente.name)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
