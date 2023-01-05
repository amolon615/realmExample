//
//  AddTaskView.swift
//  realmExample
//
//  Created by Artem on 05/01/2023.
//

import SwiftUI

struct AddTaskView: View {
    
    @State private var title: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create a new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter your task", text: $title )
                .textFieldStyle(.roundedBorder)
            
            Button {
                if title != "" {
                    realmManager.addTask(taskTitle: title)
                }
                dismiss()
            } label: {
                Text("Add task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Spacer()
        }.padding(.top, 40)
            .padding(.horizontal)
            .background(Color(hue: 1.0, saturation: 0.297, brightness: 0.905))
    }
        
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
