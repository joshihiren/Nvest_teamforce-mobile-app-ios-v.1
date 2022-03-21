//
//  ConnectCompleteView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 09/02/21.
//

import SwiftUI

struct ConnectCompleteView: View {
    
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
    var sender: Double?
    var reciever: Double?
    @ObservedObject var ImageModel: AsyncImageModel
    var delegate: PluginVaultDelegate
    
    var body: some View {
        ZStack {
            
            if (self.connect_type == .BTvault && self.isPresented) || (self.connect_type == .AnotherGX && self.isPresented) {
                Color.black.opacity(isPresented ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isPresented.toggle()
                        self.delegate.didselectwithfinalapp(Vaulttype: .complete, connecttype: self.connect_type, tupleobj: [])
                    }
                
                VStack (alignment: .center, spacing: 0) {
                    PopupNavView(isnotonelogo: true, otherlogo: "ConnectIC", BGcolor: OrangeColor)
                        .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                    
                    Text("Completed")
                        .font(.custom(MontserratSemiBoldFont, size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(OrangeColor)
                        .padding(.leading, 40)
                        .padding(.top, 40)
                    
//                    Great Job. You Have Sent *%.2f* *%@” And “Enter Name Of Receipient” Has Receieved “Enter To Amount” “Enter To Currency”
                    
                    Text(String.init(format: "Great Job. You Have Sent %.2f “%@” And Your “%@” Vault Has Receieved “%.2f” “%@”", (self.sender)!, (self.From_SelectedApp?.appName)!, (self.To_SelectedApp?.appName)!, (self.reciever)!, (self.To_SelectedCurrency?.coinName)!))
                        .font(.custom(MontserratRegularFont, size: 12))
                        .foregroundColor(TextColor)
                        .padding()
                        .padding([.leading, .trailing], 40)
                        .padding(.bottom, 20)
                        .opacity(0.5)
                    
                    self.header(title: "Your New Bitcoin Balance")
                    
                    self.amountview(isSender: false, name: self.To_SelectedApp?.appName!, img: self.To_SelectedApp?.appIcon!)
                        .padding(.bottom, 30)
                    
                    self.optionview()
                        .padding(.bottom, 40)
                }
                .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
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
                Text(String.init(format: "%f", (self.reciever)!).CoinPriceThumbRules(Coin: (self.To_SelectedCurrency?.coinSymbol)!)!)
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 20))
                    .opacity(0.4)
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
    
    func optionview() -> some View {
        HStack (alignment: .center, spacing: 20) {
            Button(action: {
                self.isPresented.toggle()
            }) {
                Text("Send")
                    .foregroundColor(.white)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .padding()
            .frame(maxWidth: Screen_width, maxHeight: 50, alignment: .center)
            .background(OrangeColor)
            
            Button(action: {
                self.isPresented.toggle()
            }) {
                Text("Bitcoin Vault")
                    .foregroundColor(OrangeColor)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .padding()
            .frame(maxWidth: Screen_width, maxHeight: 50, alignment: .center)
            .border(LineColor, width: 1)
        }
        .padding([.leading, .trailing], 40)
        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
    }
    
}

struct ConnectCompleteView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ConnectCompleteView(isPresented: $value, plugin_type: .none, connect_type: .none, connectemail: "", ImageModel: AsyncImageModel(), delegate: self as! PluginVaultDelegate)
    }
}
