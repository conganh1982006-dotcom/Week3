//
//  AddStudentView.swift
//  Week3
//
//  Created by MAY 02 on 5/10/26.
//
import SwiftUI

struct AddStudentView: View {
    @Binding var students: [Student]

    @State private var inputID: String = ""
    @State private var inputname: String = ""
    @State private var inputGPA: String = ""
    @State private var didAddStudent = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            TextField("ID", text: $inputID)
                .textFieldStyle(.roundedBorder)
            TextField("Name", text: $inputname)
                .textFieldStyle(.roundedBorder)
            TextField("GPA", text: $inputGPA)
                .textFieldStyle(.roundedBorder)
        }.padding()
        Button("Add Student") {
            if let GPA = Float(inputGPA) {
                let NewStudent  = Student(id: inputID, name: inputname, GPA: GPA)
                students.append(NewStudent)
                dismiss()
            }
        }.disabled(inputname.isEmpty)
    }
}
