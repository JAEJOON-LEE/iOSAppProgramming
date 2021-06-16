//
//  ContentView.swift
//  LoginPageEN
//
//  Created by Farukh IQBAL on 25/02/2020.
//  Copyright © 2020 Farukh IQBAL. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

struct logIn : View {

    @State var index = 0
    @Namespace var name

    var body: some View{
        NavigationView {
        VStack{
            Text("WIT")
                .font(.system(size : 30))
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .frame(width: 70)

            HStack(spacing: 0){

                Button(action: {

                    withAnimation(.spring()){

                        index = 0
                    }

                }) {

                    VStack{

                        Text("Login")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)

                            ZStack{

                            // slide animation....
                            Capsule()
                            .fill(Color.black.opacity(0.04))
                            .frame( height: 4)

                            if index == 0{

                            Capsule()
                                .fill(Color.black)
                            .frame( height: 4)
                                .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }

                Button(action: {

                    withAnimation(.spring()){

                        index = 1
                    }

                }) {

                    VStack{

                        Text("Sign Up")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)

                            ZStack{

                            // slide animation....
                            Capsule()
                            .fill(Color.black.opacity(0.04))
                            .frame( height: 4)

                            if index == 1{

                            Capsule()
                                .fill(Color.black)
                            .frame( height: 4)
                                .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
            .padding(.top,30)

            // Login View...

            // Changing Views Based On Index...

            if index == 0{
                Login(index:$index)
            }
            else if index == 1{
                SignUp(index:$index)
            }
            else{
                Home()
            }
        }
        } // navigationview
    }
}


struct Login : View {
    @Binding var index : Int
    @State var id = ""
    @State var password = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No!!"
    
    func clear(){
        self.password = ""
        self.id = ""
    }
    func errorCheck() -> String? {
        if id.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return "Check your fill"
        }
        return nil
        
    }
    func signIn() {
        if let error = errorCheck(){
            self.error = error
            self.showingAlert=true
            return
        }
        AuthService.signIn(email: id, password: password, onSuccess: {
            (user) in
            print("ok")
            self.clear()
            index=2
        }){
            (errorMessage) in
            print("error")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }

    var body: some View{
        VStack{

            HStack{

                VStack(alignment: .leading, spacing: 12) {

                    Text("Hello,")
                        .fontWeight(.bold)

                    Text("Here is WIT")
                        .font(.title)
                        .fontWeight(.bold)

                    Button(action: {}) {

                        Text("당신의 첫 인상을 관리합니다.")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                    }
                }

                Spacer(minLength: 0)


                Image(systemName: "heart.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 85, height: 85)
            }
            .padding(.horizontal,25)
            .padding(.top,30)

            VStack(alignment: .leading, spacing: 15) {

                Text("ID")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                TextField("id", text: $id)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    // shadow effect...
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                    .shadow(color: Color.black.opacity(0.08), radius:5, x:0, y:-5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                TextField("password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    // shadow effect...
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                    .shadow(color: Color.black.opacity(0.08), radius:5, x:0, y:-5)
//
//                Button(action: {}) {
//
//                    Text("Forget Password")
//                        .font(.system(size: 14))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.black)
//                }
//                .padding(.top,10)
            }
            .padding(.horizontal,25)
            .padding(.top,25)

            // Login Button....

            Button(action: signIn) {
//                NavigationLink(){
                Text("Login")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color.black ,Color.gray]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
//                }
                .cornerRadius(8)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            // Social Buttons...

            Button(action: {}) {

                HStack(spacing: 30){

                    Image(systemName: "message")
                        .font(.system(size: 26))
                        .foregroundColor(Color.black)

                    Text("LogIn using KakaoTalk")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)

                    Spacer(minLength: 0)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                }
                .padding(.horizontal,25)

//            HStack(spacing: 30){
//
//                ForEach(social,id: \.self){name in
//
//                    Button(action: {}) {
//
//                        Image(systemName: name)
//                            .renderingMode(.template)
//                            .resizable()
//                            .frame(width: 24,height: 24)
//                            .foregroundColor(Color.black)
//                    }
//                }
//            }
//            .padding(.top,25)
        }
    }
}
struct SignUp : View {
    @Binding var index : Int
    @State var id = ""
    @State var password = ""
    @State var username = ""
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No!!"
    @State private var dscText = ""
    @State private var titleText = ""
    
    func loadImage(){
        guard let inputImage = pickedImage else{ return}
        
        postImage = inputImage
    }
    func clear(){
        self.password = ""
        self.id = ""
        self.username = ""
    }
    func errorCheck() -> String? {
        if id.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || username.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return "Check your fill"
        }
        return nil
    }
    func signUp() {
        if let error = errorCheck(){
            self.error = error
            self.showingAlert=true
            return
        }
        AuthService.signUp(username: username, email: id, password: password, imageData: imageData, onSuccess: {
            (user) in
            print("ok")
            self.clear()
        }){
            (errorMessage) in
            print("error")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View{

        VStack{

            HStack{

                HStack(spacing: 12) {

                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    VStack{
                        if postImage != nil {
                            postImage!.resizable()
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        } else{
                            Image(systemName: "photo.fill").resizable()
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                                
                        }
                    }
                    
                }
                Spacer(minLength: 0)
        }
        .padding(.horizontal,25)
        .padding(.top,30)

        VStack(alignment: .leading, spacing: 15) {


            Text("ID")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("ID", text: $id)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)

            Text("Password")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                            // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)


            
            Text("Username")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("please type your first name", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                            // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(pickedImage: self.$pickedImage, showingImagePicker: self.$showingImagePicker, imageData:self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text(""),buttons: [
                .default(Text("Choose")){
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .default(Text("Take a Photo")){
                    self.sourceType = .camera
                    self.showingImagePicker = true
                }, .cancel()
            ])
        }

        // Login Button....

        Button(action:signUp) {
            Text("Sign Up")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(
                    LinearGradient(gradient: .init(colors: [Color.black, Color.gray]),
                                    startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
        }
        .padding(.horizontal,25)
        .padding(.top,25)

        // Social Buttons...

        }
    }
}
