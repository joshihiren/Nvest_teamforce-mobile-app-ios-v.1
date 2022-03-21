//
//  Loginview.swift
//  TeamForce
//
//  Created by Hiren Joshi on 16/01/21.
//

import SwiftUI

struct Loginview: View {
    
    @State var LoginPressed: Int? = nil
    @State var CreatePressed: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center, spacing: 80) {
                Rectangle()
                    .foregroundColor(BackgroundColor)
                
                SplashIMG()
                    .animation(.easeIn)
                
                optionview()
                    .animation(.easeIn)
                
                Rectangle()
                    .foregroundColor(BackgroundColor)
                
                preregisterview()
                    .animation(.easeInOut)
                
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    func optionview() -> some View {
        VStack (alignment: .center, spacing: 20) {
            NavigationLink(destination: ValidLogin(loginVM: LoginCallingModel()).environmentObject( DataItem()), tag: 1, selection: $LoginPressed) {
                Button(action: {
                    print("login tapped")
                    self.LoginPressed = 1
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.custom(MontserratRegularFont, size: 16))
                }
                .padding()
                .padding([.leading, .trailing], 80)
                .background(OrangeColor)
            }
            Divider()
                .padding([.leading, .trailing], 90)
            
            NavigationLink(destination: HomeTabbar(index: 0, isPlugin: false, plugin_type: .none, connect_type: .none, vault_type: .none), tag: 1, selection: $CreatePressed) {
                Button(action: {
                    print("Create pressed")
                    self.CreatePressed = 1
                }) {
                    Text("Create")
                        .foregroundColor(TextColor)
                        .font(.custom(MontserratRegularFont, size: 16))
                }
                .padding()
                .padding([.leading, .trailing], 80)
                .border(LineColor, width: 1)
            }
            .navigationBarHidden(true)
        }
    }
    
    func preregisterview() -> some View {
        HStack {
            Text("Click Here If You Were")
                .font(.custom(MontserratRegularFont, size: 16))
            Text("Pre-Registered")
                .font(.custom(MontserratBoldFont, size: 16))
        }
        .onTapGesture {
            print("Preregister pressed")
        }
        .padding(.bottom, 30)
    }
    
}

struct Loginview_Previews: PreviewProvider {
    static var previews: some View {
        Loginview()
    }
}
