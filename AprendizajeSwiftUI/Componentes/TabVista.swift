//
//  TabVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 31/12/25.
//

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
#Preview {
    TabVista()
}
