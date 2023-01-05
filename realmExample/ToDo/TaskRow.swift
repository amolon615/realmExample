//
//  TaskRow.swift
//  realmExample
//
//  Created by Artem on 05/01/2023.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: completed ? "checkmark.circle" : "circle")
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Reading", completed: false)
    }
}
