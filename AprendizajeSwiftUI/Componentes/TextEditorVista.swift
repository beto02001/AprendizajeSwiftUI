//
//  TextEditorVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

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
            
            Text("\(counter)")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(counter <= 280 ? .green : . orange)
        }
    }
}

#Preview {
    TextEditorVista()
}
