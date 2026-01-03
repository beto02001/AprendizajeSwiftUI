//
//  ObservedAndStateObjectPropagation.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 02/01/26.
//

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
            Text("\(viewModel.counter)")
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

#Preview {
    ObservedAndStateObjectPropagation()
}
