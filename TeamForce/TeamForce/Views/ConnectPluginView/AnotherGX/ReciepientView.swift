//
//  ReciepientView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 13/02/21.
//

import SwiftUI

class ReciepientItem: ObservableObject {
    @Published var email: String = ""
}

struct ReciepientView: View {
    
    @Binding var isPresented: Bool
    @State var vault_type: ConnectOptionType
    @State var connect_type: TransferType
    @State var connectemail: String?
    var delegate: PluginVaultDelegate
    
    @EnvironmentObject private var item: ReciepientItem
    @State private var rexgemail = FieldChecker()
    
    var isValid:Bool {
        item.email.isValidEmail()
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isPresented.toggle()
                }
            if (self.connect_type == .BTvault && self.isPresented) || (self.connect_type == .AnotherGX && self.isPresented ) {
                VStack (alignment: .center, spacing: 0) {
                    PopupNavView(isnotonelogo: true, otherlogo: "ConnectIC", BGcolor: OrangeColor)
                        .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                    SelectionFlowView()
                        .padding(.bottom, 80)
                        .padding(.top, 20)
                    
                    VStack {
                        Text("Reciepient")
                            .font(.custom(MontserratSemiBoldFont, size: 30))
                            .foregroundColor(OrangeColor)
                            .padding(.bottom, 50)
                        
                        Text("What Is Your Friends Email?")
                            .font(.custom(MontserratRegularFont, size: 12))
                            .foregroundColor(TextColor)
                            .padding()
                            .opacity(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)
                    
                    self.centerview()
                        .padding(.bottom, 50)
                    
                    Button(action: {
                        self.isPresented.toggle()
                        self.delegate.didselectwithfinalapp(Vaulttype: .Reciepient, connecttype: self.connect_type, tupleobj: [self.item.email])
                    }) {
                        Text("Proceed To Select Currency")
                            .foregroundColor(Color.white)
                            .font(.custom(MontserratRegularFont, size: 16))
                    }
                    .frame(maxWidth: Screen_width / 1.5, alignment: .center)
                    .padding()
                    .border(LineColor.opacity(0.3), width: 1)
                    .background(OrangeColor)
                    .opacity(self.isValid ? 1.0 : 0.5)
                    .padding(.bottom, 40)
                }
                .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    func enteremail() -> some View {
        TextFieldWithValidator(title: "Enter Email",
                               value: $item.email,
                               checker: $rexgemail,
                               onCommit: submit) { v in
            // validation closure where ‘v’ is the current value
            if( !v.isEmail() ) {
                return "email is not in correct format"
            }
            
            return nil
        }
        .animation(.easeIn)
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
    }
    
    func centerview() -> some View {
        HStack (spacing: 0) {
            HStack {
                enteremail()
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 20))
            }
            .frame(maxWidth: Screen_width, maxHeight: 25, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            
            HStack (spacing: 10) {
                Image(systemName: "envelope")
                    .foregroundColor(OrangeColor)
            }
            .frame(maxWidth: 30, maxHeight: 25, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
        }
        .padding([.leading, .trailing], 40)
        .frame(maxWidth: Screen_width, alignment: .center)
    }
    
    func submit() { }
}

struct ReciepientView_Previews: PreviewProvider {
    static var previews: some View {
        ReciepientView(isPresented: .constant(true), vault_type: .Reciepient, connect_type: .AnotherGX, delegate: self as! PluginVaultDelegate)
            .environmentObject(ReciepientItem())
    }
}
