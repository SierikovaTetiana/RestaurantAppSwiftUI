//
//  ProfileTextFieldView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 22.08.2022.
//

import SwiftUI

struct ProfileTextFieldView: View {
    var image: Image
    var description: String
    var textIsEmpty: Bool
    var keyPathForUserInfo: WritableKeyPath<ProfileModel, String?>
    var fieldToChangeInFirebase: String
    @State var text: String
    @State var fieldToUpdate = ""
    @State var didEdited = false
    @State var showingAlertChangeUserInfo = false
    @State var conformChangesFromAlert = false
    @State var selectedDate = Date()
    @State var dateToday = Date().formatted(.dateTime.day().month().year())
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .leading)
                .foregroundColor(Color("darkGreen"))
            
            if ProfileModelForListView.bDay.description == description {
                ZStack {
                    DatePicker("label", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                    let formatedDate = selectedDate.formatted(.dateTime.day().month().year())
                    Text(formatedDate == dateToday ? "\(description)" : "\(formatedDate)")
                        .foregroundColor(formatedDate == dateToday ? .gray : .black)
                        .userInteractionDisabled()
                }
            } else {
                TextField("", text: $text, onEditingChanged: { edited in
                    didEdited = edited ? false : true
                }) .placeholder(when: text.isEmpty) {
                    Text(description)
                        .foregroundColor(textIsEmpty ? .gray : .black)
                }
            }
            
            Spacer()
            
            if ProfileModelForListView.password.description == description {
                changePasswordButton
            } else {
                if ProfileModelForListView.bDay.description == description {
                    ZStack {
                        DatePicker("label", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .leading)
                            .foregroundColor(Color("darkGreen"))
                            .userInteractionDisabled()
                    }
                } else {
                    editButton
                }
            }
        }
        .padding(.horizontal)
        .background(AlertWithTextField(textFromAlert: $fieldToUpdate, show: $showingAlertChangeUserInfo, conformChanges: $conformChangesFromAlert, title: "Ви хочете змінити \(description)?", message: ""))
        .onChange(of: conformChangesFromAlert, perform: { newValue in
            if conformChangesFromAlert && fieldToUpdate != "" && ProfileModelForListView.password.description != description {
                profileViewModel.changeUserInfo(keyPathForUserInfo: keyPathForUserInfo, fieldToChangeInFirebase: fieldToChangeInFirebase, valueToChange: fieldToUpdate)
            }
        })
        .onDisappear {
            if text != "" && didEdited && ProfileModelForListView.password.description != description {
                profileViewModel.changeUserInfo(keyPathForUserInfo: keyPathForUserInfo, fieldToChangeInFirebase: fieldToChangeInFirebase, valueToChange: text)
            }
            if ProfileModelForListView.bDay.description == description && selectedDate.formatted(.dateTime.day().month().year()) != dateToday {
                profileViewModel.changeUserInfo(keyPathForUserInfo: keyPathForUserInfo, fieldToChangeInFirebase: fieldToChangeInFirebase, valueToChange: selectedDate.formatted(.dateTime.day().month().year()))
            }
        }
        Divider()
    }
}

extension ProfileTextFieldView {
    var editButton: some View {
        return Button {
            showingAlertChangeUserInfo = true
            print("Edit tapped")
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(Color("darkGreen"))
        }
    }
    
    var changePasswordButton: some View {
        NavigationLink {
            ChangePasswordView()
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(Color("darkGreen"))
        }
    }
}

struct NoHitTesting: ViewModifier {
    func body(content: Content) -> some View {
        SwiftUIWrapper { content }.allowsHitTesting(false)
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}


//TODO: Dismiss keyboard when tap outside in other(not Profile) views
