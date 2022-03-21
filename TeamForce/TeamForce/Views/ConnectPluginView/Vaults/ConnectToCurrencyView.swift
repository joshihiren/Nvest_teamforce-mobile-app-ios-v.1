//
//  ConnectToCurrencyView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 09/02/21.
//

import SwiftUI

struct ConnectToCurrencyView: View, ConnectListPopupDelegate {
    
    @Binding var isPresented: Bool
    @State var vault_type: ConnectOptionType
    @State var connect_type: TransferType
    @State var connectemail: String?
    var From_Apps: [RegisterAppUserApp]?
    var From_SelectedApp: RegisterAppUserApp?
    var From_Currencies: [CurrencyCoinsData]?
    var From_SelectedCurrency: CurrencyCoinsData?
    var To_SelectedApp: RegisterAppUserApp?
    @ObservedObject var ImageModel: AsyncImageModel
    var delegate: PluginVaultDelegate
    
    @State private var destinationCurrency: CurrencyCoinsData?
    @State private var isDropDwonOpen: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(isPresented ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isPresented.toggle()
                }
            if (self.connect_type == .BTvault && self.isPresented) || (self.connect_type == .AnotherGX && self.isPresented) {
                VStack (alignment: .center, spacing: 0) {
                    PopupNavView(isnotonelogo: true, otherlogo: "ConnectIC", BGcolor: OrangeColor)
                        .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                    SelectionFlowView()
                        .padding(.bottom, 80)
                        .padding(.top, 20)
                    
                    Text("Destination Currency")
                        .font(.custom(MontserratSemiBoldFont, size: 30))
                        .foregroundColor(OrangeColor)
                    
                    Text(String.init(format: "Select The Currency That You Would To Deposit Into In “%@”", self.To_SelectedApp!.appName))
                        .font(.custom(MontserratRegularFont, size: 12))
                        .foregroundColor(TextColor)
                        .padding()
                        .padding(.bottom, 50)
                        .opacity(0.5)
                    
                    self.options()
                        .padding(.bottom, 50)
                }
                .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
                if self.isDropDwonOpen {
                    ConnectListPopupView(title: String.init(format: "Vault For %@", (self.To_SelectedApp?.appName)!), lefttitle: "With Balances", righttitle: "All Apps", appcode: self.To_SelectedApp!.appCode, profileid: self.To_SelectedApp!.profileId, isPresented: .constant(true), type: .coin, connect_type: self.connect_type, vault_type: self.vault_type, ImageModel: AsyncImageModel(), coinmodel: CurrencyTypeModel(), appmodel: SelectedAppModel(), delegate: self)
                        .environmentObject(connectpopItem())
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    func options() -> some View {
        VStack (alignment: .center, spacing: self.isDropDwonOpen ? 10 : 60) {
            Button(action: {
                self.isDropDwonOpen.toggle()
            }) {
                HStack (spacing: 5) {
                    if (self.destinationCurrency != nil && self.ImageModel.isLoadingIMG) {
                        Image(uiImage: self.ImageModel.imageIC.image!)
                            .resizable()
                            .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                    }
                    
                    if (self.destinationCurrency == nil || self.destinationCurrency!.coinName.isEmpty)
                    {
                        Text("Select One Of Your Assets")
                            .foregroundColor(TextColor)
                            .font(.custom(MontserratRegularFont, size: 16))
                            .opacity(0.4)
                            .frame(minWidth: Screen_width / 1.5, alignment: .center)
                    }
                    else {
                        Text(self.destinationCurrency!.coinName)
                            .foregroundColor(TextColor)
                            .font(.custom(MontserratRegularFont, size: 16))
                            .opacity(1.0)
                            .frame(minWidth: Screen_width / 1.5, alignment: .center)
                    }
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 16, weight: .regular))
                        .opacity(0.4)
                        .foregroundColor(TextColor)
                }
                .onAppear(perform: {
                    if self.destinationCurrency != nil {
                        self.ImageModel.downloadedFrom(link: self.destinationCurrency!.coinImage)
                    }
                })
            }
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            
            Button(action: {
                self.isPresented.toggle()
                self.delegate.didselectwithfinalapp(Vaulttype: .tocurrency, connecttype: self.connect_type, tupleobj: [self.destinationCurrency as Any])
            }) {
                Text("Next Step")
                    .foregroundColor(Color.white)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .frame(minWidth: Screen_width / 1.5, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            .background(OrangeColor)
            .opacity((self.destinationCurrency == nil || self.destinationCurrency!.coinName.isEmpty) ? 0.5 : 1.0)
            .onDisappear(perform: {
                self.destinationCurrency = nil
            })
        }
        .frame(minWidth: Screen_width, alignment: .center)
        .background(BackgroundColor)
    }
    
    func didselectcell(type: ConnectListtype, connecttype: TransferType, tupleobj: [Any]) {
        self.isDropDwonOpen.toggle()
        self.destinationCurrency = tupleobj.last as? CurrencyCoinsData
        self.ImageModel.downloadedFrom(link: self.destinationCurrency!.coinImage)
    }
}

struct ConnectToCurrencyView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ConnectToCurrencyView(isPresented: $value, vault_type: .none, connect_type: .none, connectemail: "", ImageModel: AsyncImageModel(), delegate: self as! PluginVaultDelegate)
    }
}
