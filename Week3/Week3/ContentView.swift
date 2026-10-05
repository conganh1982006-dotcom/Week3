//
//  ContentView.swift
//  Week3
//
//  Created by MAY 02 on 5/10/26.
//

import SwiftUI
struct Student {
    var id: String
    var name: String
    var GPA: Float
}

struct ContentView: View {
    @State private var students: [Student] = [
        Student(id: "SE1", name: "John", GPA: 3.5),
        Student(id: "SE2", name: "Jane", GPA: 3.2),
        Student(id: "SE3", name: "Bob", GPA: 3.8),
        Student(id: "SE4", name: "Alice", GPA: 3.0),
    ]
    @State private var searchName: String = ""
    @State private var searchResult: String = ""
    @State private var numofstudent: Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "receipt")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("BlackBoard").font(Font.largeTitle).foregroundStyle(Color.blue)


                HStack {
                    TextField("Search student name", text: $searchName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Search") {
                        numofstudent = students.count
                        searchStudent()
                    }
                }
                
                Text(searchResult)
                Text("Number of students: \(students.count)")
                List(students, id: \.id) { student in
                    NavigationLink {
                        EditStudentView(
                            student: student,
                            students: $students
                        )
                    } label: {
                        HStack {
                            Text("Name: \(student.name)")
                            Spacer()
                            Text("GPA: \(student.GPA)")
                        }
                    }
                }
                
                VStack {
                    Text("Student manager")
                    NavigationLink{
                        AddStudentView(students: $students)
                    } label: {
                        HStack {
                            Text("Add Student")
                        }.padding()
                    }
                    
                }
                
                
            }.padding()
        }.navigationTitle(Text("Student manager"))
        
    }
    func searchStudent() {
        if let student = students.first(where: { item in
            item.name.lowercased() == searchName.lowercased()
        }) {
            searchResult = "Found: \(student.name) - GPA: \(student.GPA)"
        } else {
            searchResult = "Student not found"
        }
    }
}

        
#Preview {
    ContentView()
}
