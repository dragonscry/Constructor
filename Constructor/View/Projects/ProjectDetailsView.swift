//
//  ProjectDetailsView.swift
//  Constructor
//
//  Created by Denys on 13.07.2022.
//

import SwiftUI

struct ProjectDetailsView: View {
    
    //@EnvironmentObject var coreDataVM: CoreDataRelationshipViewModel
    //@EnvironmentObject var projectVM: ProjectsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @Environment(\.presentationMode) var presentationMode
    var project: ProjectEntity
    @State var name = ""
    
    var body: some View {
        VStack {
            HStack {
                DefaultPhotoView()
                VStack(alignment: .leading) {
                    TextField(project.name ?? "", text: $name)
                        .underlineTextField()
                    Text("Budget is: \(project.budget.asString2Decimal())")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 50)
            
            Button {
                superVM.updateProject(project: project, name: name)
                presentationMode.wrappedValue.dismiss()
            } label: {
                DefaultButton(text: "Save")
            }
            
            Spacer()
        }
        .onAppear(perform: defaultValues)
    }
    
    func defaultValues() {
        self.name = project.name ?? ""
    }
}

//struct ProjectDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectDetailsView()
//    }
//}
