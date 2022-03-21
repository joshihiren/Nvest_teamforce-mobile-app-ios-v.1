//
//  ConnectFromAppView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 05/02/21.
//

import SwiftUI

struct ConnectFromAppView: View, ConnectListPopupDelegate {
    
    @Binding var isPresented: Bool
    @State var vault_type: ConnectOptionType
    @State var connect_type: TransferType
    @State var connectemail: String?
    @ObservedObject var ImageModel: AsyncImageModel
    var delegate: PluginVaultDelegate
    
    @State private var isDropDwonOpen: Bool = false
    @State private var selectedApp: RegisterAppUserApp!
    @State private var Appslist: [RegisterAppUserApp]!
    
    var body: some View {
        ZStack {
            Color.black.opacity(isPresented ? 0.5 : 0)
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
                    
                    Text("Select From App")
                        .font(.custom(MontserratSemiBoldFont, size: 30))
                        .foregroundColor(OrangeColor)
                    
                    Text("Which One Of Your GX Apps Are You Going To Send The Funds From")
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
            }
            
            if self.isDropDwonOpen {
                ConnectListPopupView(title: "All your Apps", lefttitle: "With Balances", righttitle: "All Apps", email: self.connectemail, isPresented: .constant(true), type: .app, connect_type: self.connect_type, vault_type: self.vault_type, ImageModel: AsyncImageModel(), coinmodel: CurrencyTypeModel(), appmodel: SelectedAppModel(), delegate: self)
                    .environmentObject(connectpopItem())
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
                    if (self.selectedApp != nil && self.ImageModel.isLoadingIMG) {
                        Image(uiImage: self.ImageModel.imageIC.image!)
                            .resizable()
                            .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                    }
                    
                    if (self.selectedApp == nil || self.selectedApp.appName.isEmpty)
                    {
                        Text("See All Registered Apps")
                            .foregroundColor(TextColor)
                            .font(.custom(MontserratRegularFont, size: 16))
                            .opacity(0.4)
                            .frame(minWidth: Screen_width / 1.5, alignment: .center)
                    }
                    else {
                        Text(self.selectedApp.appName)
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
                    if self.selectedApp != nil {
                        self.ImageModel.downloadedFrom(link: self.selectedApp.appIcon)
                    }
                })
            }
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            
            Button(action: {
                self.isPresented.toggle()
                self.delegate.didselectwithfinalapp(Vaulttype: .fromapp, connecttype: self.connect_type, tupleobj: [self.Appslist as Any, self.selectedApp as Any])
            }) {
                Text("Proceed To Select Currency")
                    .foregroundColor(Color.white)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .frame(minWidth: Screen_width / 1.5, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            .background(OrangeColor)
            .opacity((self.selectedApp == nil || self.selectedApp.appName.isEmpty) ? 0.5 : 1.0)
            .onDisappear(perform: {
                self.selectedApp = nil
            })
        }
        .frame(minWidth: Screen_width, alignment: .center)
        .background(BackgroundColor)
    }
    
    func didselectcell(type: ConnectListtype, connecttype: TransferType, tupleobj: [Any]) {
        self.isDropDwonOpen.toggle()
        self.Appslist = tupleobj.first as? [RegisterAppUserApp]
        self.selectedApp = tupleobj.last as? RegisterAppUserApp
        self.ImageModel.downloadedFrom(link: self.selectedApp.appIcon)
    }
}

struct ConnectFromAppView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ConnectFromAppView(isPresented: $value, vault_type: .none, connect_type: .none, connectemail: "", ImageModel: AsyncImageModel(), delegate: self as! PluginVaultDelegate)
    }
}
