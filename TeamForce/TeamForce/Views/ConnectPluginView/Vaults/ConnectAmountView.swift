//
//  ConnectAmountView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 09/02/21.
//

import SwiftUI
import Combine
import Foundation

class AmountItem: ObservableObject {
    @Published var sender: String = ""
    @Published var reciever: String = ""
}

struct ConnectAmountView: View {
    
    @Binding var isPresented: Bool
    @State var plugin_type: PluginType
    @State var connect_type: TransferType
    @State var connectemail: String?
    var From_Apps: [RegisterAppUserApp]?
    var From_SelectedApp: RegisterAppUserApp?
    var From_Currencies: [CurrencyCoinsData]?
    var From_SelectedCurrency: CurrencyCoinsData?
    var To_SelectedApp: RegisterAppUserApp?
    var To_SelectedCurrency: CurrencyCoinsData?
    var delegate: PluginVaultDelegate
    @ObservedObject var ImageModel: AsyncImageModel
    
    @EnvironmentObject var item: AmountItem
    @State var amounts = FieldChecker()
    
    var isValid:Bool {
        item.sender.IsContainDigit() && item.reciever.IsContainDigit()
    }
    
    var body: some View {
        ZStack {
            if (self.connect_type == .BTvault && self.isPresented) || (self.connect_type == .AnotherGX && self.isPresented) {
                Color.black.opacity(isPresented ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isPresented.toggle()
                    }
                
                VStack (alignment: .center, spacing: 0) {
                    PopupNavView(isnotonelogo: true, otherlogo: "ConnectIC", BGcolor: OrangeColor)
                        .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                    
                    SelectionFlowView()
                        .padding(.bottom, 50)
                        .padding(.top, 20)
                    
                    Text("Amount")
                        .font(.custom(MontserratSemiBoldFont, size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(OrangeColor)
                        .padding(.leading, 40)
                    
                    self.header(title: "You Will Be Sending")
                    
                    self.amountview(isSender: true, name: self.From_SelectedApp?.appName!, img: self.From_SelectedApp?.appIcon!)
                        .padding(.bottom, 20)
                    
                    self.header(title: String.init(format: "“%@” Should Be Recieving", (self.To_SelectedApp?.appName)! as String))
                    
                    self.amountview(isSender: false, name: self.To_SelectedApp?.appName!, img: self.To_SelectedApp?.appIcon!)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        self.submit()
                    }) {
                        Text("Send")
                            .foregroundColor(Color.white)
                            .font(.custom(MontserratRegularFont, size: 16))
                    }
                    .frame(minWidth: Screen_width / 1.5, alignment: .center)
                    .padding()
                    .border(LineColor.opacity(0.3), width: 1)
                    .background(OrangeColor)
                    .padding([.bottom, .top], 30)
                    .padding(.bottom, 30)
                    .opacity(isValid ? 1 : 0.5)
                }
                .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .keyboardAdaptive()
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    func enteramount(isSender: Bool) -> some View {
        TextFieldWithValidator(title: isSender ? "$0.00" : "0.00",
                               value: isSender ? $item.sender : $item.reciever,
                               checker: $amounts,
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
        .keyboardType(.decimalPad)
    }
    
    func submit() {
        if isValid {
            self.isPresented.toggle()
            self.delegate.didselectwithfinalapp(Vaulttype: .amount, connecttype: self.connect_type, tupleobj: [self.item.sender as Any, self.item.reciever as Any])
        }
    }
    
    func header(title: String?) -> some View {
        VStack {
            Text(title!)
                .foregroundColor(TextColor)
                .font(.custom(MontserratRegularFont, size: 12))
                .opacity(0.4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .trailing], 40)
        .padding(.top, 15)
        .padding(.bottom, 5)
    }
    
    func amountview(isSender: Bool, name: String?, img: String?) -> some View {
        HStack (spacing: 0) {
            HStack {
                //                NormalTextField(isSender ? "$0.00" : "0.00",
                //                                text: isSender ? $item.sender : $item.reciever)
                
                enteramount(isSender: isSender)
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 20))
            }
            .frame(maxWidth: Screen_width, maxHeight: 25, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            
            HStack (spacing: 10) {
                Text(name!)
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 15))
                    .opacity(0.4)
                
                if self.ImageModel.isLoadingIMG {
                    Image(uiImage: self.ImageModel.imageIC.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                }
            }
            .frame(maxWidth: Screen_width, maxHeight: 25, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
        }
        .padding([.leading, .trailing], 40)
        .frame(maxWidth: Screen_width, alignment: .center)
        .onAppear(perform: {
            if img != nil {
                self.ImageModel.downloadedFrom(link: img)
            }
        })
    }
    
}

struct ConnectAmountView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ConnectAmountView(isPresented: $value, plugin_type: .none, connect_type: .none, connectemail: "", delegate: self as! PluginVaultDelegate, ImageModel: AsyncImageModel())
    }
}
