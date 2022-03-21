//
//  ValidLogin.swift
//  TeamForce
//
//  Created by Hiren Joshi on 17/01/21.
//

import Foundation
import SwiftUI
import Combine

// Save email and password for futher process
class DataItem: ObservableObject { // observable object
    @Published var username: String = "" // observable property
    @Published var password: String = "" // observable property
}

struct ValidLogin: View {
    
    @State var isValidPass: Bool = false
    @EnvironmentObject var item:DataItem // data model reference
    @State var usernameValid = FieldChecker() // validation state of username field
    @State var passwordValid = FieldChecker() // validation state of password field
    @State var passwordToggleValid = FieldChecker() // validation state of password field
    @State var passwordHidden = true
    @State var char: Bool = false
    @State var upper: Bool = false
    @State var num: Bool = false
    @State var special: Bool = false
    @State var validPassword: Bool = false
    @State var isMfA: Bool = false
    @State var LoginPressed: Int? = nil
    @ObservedObject var loginVM: LoginCallingModel
    
    var isValid:Bool {
        passwordToggleValid.valid && usernameValid.valid
    }
    
    // Create username function for email address
    func username() -> some View {
        
        TextFieldWithValidator( title: "E-Mail",
                                value: $item.username,
                                checker: $usernameValid,
                                onCommit: submit) { v in
            // validation closure where ‘v’ is the current value
            
            if( v.isEmpty ) {
                return "email cannot be empty"
            }
            if( !v.isEmail() ) {
                return "email is not in correct format"
            }
            
            return nil
        }
        .animation(.easeIn)
        .autocapitalization(.none)
        //                    .padding( usernameValid.padding )
        //        .overlay( ValidatorMessageInline( message: usernameValid.errorMessage ),alignment: .bottom)
        
    }
    
    // Create function for passowrd
    func passwordToggle() -> some View  {
        
        HStack {
            
            SecureFieldWithValidator(title: "Password",
                                     value: $item.password,
                                     checker: $passwordToggleValid,
                                     hidden: $passwordHidden) {
                
            } validator: { (value) -> String? in
                if( value.isEmpty ) {
                    return "password cannot be empty"
                }
                else {
                    self.char = value.IsContainCharacter()
                    self.num = value.IsContainDigit()
                    self.special = value.IsContainSpecialCharacter()
                    self.upper = value.IsContainUppercase()
                    self.validPassword = self.char && self.num && self.special && self.upper && value.count >= 8 ? true : false
                }
                return nil
            }
            
            //            PasswordToggleField( value:$item.password,
            //                                 checker:$passwordToggleValid,
            //                                 hidden:$passwordHidden ) { v in
            //                if( v.isEmpty ) {
            //                    return "password cannot be empty"
            //                }
            //                return nil
            //            }
            .autocapitalization(.none)
            //            .padding( passwordToggleValid.padding )
            //            .overlay( ValidatorMessageInline( message: passwordToggleValid.errorMessageOrNilAtBeginning ),alignment: .bottom)
            Button( action: {
                self.passwordHidden.toggle()
            }) {
                Group {
                    if( passwordHidden ) {
                        Image( systemName: "eye.slash")
                    }
                    else {
                        Image( systemName: "eye")
                    }
                }
                .foregroundColor(OrangeColor)
            }
        }
        .animation(.easeIn)
    }
    
    // create function for submit and call api.
    func submit() {
        if( isValid ) {
            print( "submit:\nusername:\(self.item.username)\npassword:\(self.item.password)")
            loginVM.loginAPI(email: self.item.username, password: self.item.password) { (ismfa) in
                if ismfa {
                    self.isMfA = true
                }
                else {
                    self.isMfA = false
                }
                self.LoginPressed = 1
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            ZStack (alignment: .leading) {
                
                VStack (alignment: .leading, spacing: 50) {
                    
                    Rectangle()
                        .foregroundColor(BackgroundColor)
                    
                    VStack (alignment: .leading) {
                        Text("Login")
                            .foregroundColor(OrangeColor)
                            .font(.custom(MontserratSemiBoldFont, size: 55))
                        
                        HStack (spacing: 10) {
                            if self.isValidPass {
                                Button(action: {
                                    self.isValidPass.toggle()
                                }) {
                                    Image(systemName: "arrow.backward").font(.system(size: 16, weight: .regular))
                                }
                            }
                            Text(self.isValidPass ? "Step 1: Enter Your Password" : "Step 1: Enter Your Email")
                                .foregroundColor(TextColor)
                                .font(.custom(MontserratRegularFont, size: 15))
                        }
                    }
                    
                    if self.isValidPass {
                        // SecureTextField("Password", text: $passTXT)
                        passwordToggle()
                            .padding()
                            .frame(
                                minWidth: 0,
                                idealWidth: nil,
                                maxWidth: .infinity,
                                minHeight: 60,
                                idealHeight: 60,
                                maxHeight: 60,
                                alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(LineColor.opacity(0.5), lineWidth: 1)
                            )
                        
                        VStack (alignment: .leading, spacing: 25) {
                            Text("8 Characters")
                                .font(.custom(MontserratRegularFont, size: 16))
                                .foregroundColor(validPassword ? OrangeColor : Color.gray.opacity(0.5))
                            Text("1 Upper Case")
                                .font(.custom(MontserratRegularFont, size: 16))
                                .foregroundColor(upper ? OrangeColor : Color.gray.opacity(0.5))
                            Text("1 Digit")
                                .font(.custom(MontserratRegularFont, size: 16))
                                .foregroundColor(num ? OrangeColor : Color.gray.opacity(0.5))
                            Text("1 Special Character")
                                .font(.custom(MontserratRegularFont, size: 16))
                                .foregroundColor(special ? OrangeColor : Color.gray.opacity(0.5))
                        }
                        .animation(.easeIn)
                    }
                    else {
                        // NormalTextField("E-Mail", text: $emailTXT)
                        username()
                            .padding()
                            .frame(
                                minWidth: 0,
                                idealWidth: nil,
                                maxWidth: .infinity,
                                minHeight: 60,
                                idealHeight: 60,
                                maxHeight: 60,
                                alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(LineColor.opacity(0.5), lineWidth: 1)
                            )
                    }
                    
                    
                    NavigationLink(destination: HomeTabbar(index: 0, isPlugin: false, plugin_type: .none, connect_type: .none, vault_type: .none), tag: 1, selection: $LoginPressed) {
                        Button(action: {
                            print("Next pressed")
                            if !self.isValidPass && usernameValid.valid {
                                self.isValidPass.toggle()
                            }
                            else {
                                submit()
                            }
                        }) {
                            Text("Next")
                                .foregroundColor(TextColor)
                                .font(.custom(MontserratRegularFont, size: 16))
                                .opacity(!self.isValidPass && usernameValid.valid ? 1.0 : self.isValidPass && isValid && self.validPassword ? 1.0 : 0.4)
                        }
                        .padding()
                        .frame(
                            minWidth: 0,
                            idealWidth: nil,
                            maxWidth: 200,
                            minHeight: 60,
                            idealHeight: 60,
                            maxHeight: 60,
                            alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(LineColor.opacity(0.5), lineWidth: 1)
                        )
                        .opacity(!self.isValidPass && usernameValid.valid ? 1.0 : self.isValidPass && isValid && self.validPassword ? 1.0 : 0.4)
                        .disabled(!self.isValidPass ? false : (self.isValidPass && self.validPassword && self.validPassword ? false : true))
                    }
                    
                    Rectangle()
                        .foregroundColor(BackgroundColor)
                    
                    HStack {
                        Text("Click Here To")
                            .font(.custom(MontserratRegularFont, size: 16))
                        Text("Register")
                            .font(.custom(MontserratBoldFont, size: 16))
                    }
                    .onTapGesture {
                        print("Register pressed")
                    }
                    .padding(.bottom, 30)
                }
            }
            .animation(.easeIn)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 48)
        }
        .navigationBarHidden(true)
    }
    
}

#if DEBUG
struct ValidLogin_Previews: PreviewProvider {
    static var previews: some View {
        ValidLogin(loginVM: LoginCallingModel())
            .preferredColorScheme(.dark)
            .environmentObject( DataItem() )
    }
}
#endif
