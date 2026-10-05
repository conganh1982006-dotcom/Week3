import SwiftUI

struct EditStudentView: View {

    var student: Student
    @Binding var students: [Student]

    @State private var editName: String = ""
    @State private var editGPA: String = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {

            Text("ID: \(student.id)")

            TextField("Replace Name", text: $editName)
                .textFieldStyle(.roundedBorder)
                .padding()

            TextField("Replace GPA", text: $editGPA)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Save") {

                if let GPA = Float(editGPA) {

                    if let index = students.firstIndex(where: { item in
                        item.id == student.id
                    }) {
                        students[index].name = editName
                        students[index].GPA = GPA
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            editName = student.name
            editGPA = String(student.GPA)
        }
    }
}
