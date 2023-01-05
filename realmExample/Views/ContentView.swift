//
//  ContentView.swift
//  realmExample
//
//  Created by Artem on 05/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddTaskView = false
    @StateObject var realmManager = RealmManager()
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            TasksView().environmentObject(realmManager)
            SmallAddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
        }
        .sheet(isPresented: $showAddTaskView){
            AddTaskView().environmentObject(realmManager)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 1.0, saturation: 0.297, brightness: 0.905))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
