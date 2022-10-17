//
//  AddProjectView.swift
//  Constructor
//
//  Created by Denys on 13.07.2022.
//

import SwiftUI

struct AddProjectView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var projectVM: ProjectsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @State var name = ""
    @State var budget = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    DefaultPhotoView()
                    VStack {
                        TextField("Type Project Name", text: $name)
                            .underlineTextField()
                        TextField("Type Project Budget", text: $budget)
                            .numericTextField()
                            .underlineTextField()
                    }
                        
                }
                .padding(.bottom, 20)
                
                Button {
                    superVM.unselectAllProjects()
                    superVM.addProject(name: name, budget: budget)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    DefaultButton(text: "Save")
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .navigationTitle("Add Project")
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
