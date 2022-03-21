//
//  PopupLottieView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 09/02/21.
//

import SwiftUI
import Lottie

struct PopupLottieView: View {
    
    @Binding var isPresented: Bool
    @State var plugin_type: PluginType
    @State var connect_type: TransferType
    @State var connectemail: String?
    @ObservedObject var trans_model: TransferModel
    var From_Apps: [RegisterAppUserApp]?
    var From_SelectedApp: RegisterAppUserApp?
    var From_Currencies: [CurrencyCoinsData]?
    var From_SelectedCurrency: CurrencyCoinsData?
    var To_SelectedApp: RegisterAppUserApp?
    var To_SelectedCurrency: CurrencyCoinsData?
    var sender: Double?
    var reciever: Double?
    var delegate: PluginVaultDelegate
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center, spacing: 0) {
                if (self.connect_type == .BTvault && self.isPresented) || (self.connect_type == .AnotherGX && self.isPresented) {
                    PopupNavView(isnotonelogo: true, otherlogo: "ConnectIC", BGcolor: OrangeColor)
                    .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                }
                
                animation()
                    .padding(40)
            }
            .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            if (self.connect_type == .BTvault && self.isPresented) || (self.connect_type == .AnotherGX && self.isPresented) {
                let param = VaultTransferParam.init(token: UserInfoData.shared.userinfo(infotype: .accessToken)
                                                    , email: (self.connectemail)!
                                                    , from_appcode: (self.From_SelectedApp?.appCode)!
                                                    , from_profileid: (self.From_SelectedApp?.profileId)!
                                                    , from_coin: (self.From_SelectedCurrency?.coinSymbol)!
                                                    , to_appcode: (self.To_SelectedApp?.appCode)!
                                                    , to_profileid: (self.To_SelectedApp?.profileId)!
                                                    , to_coin: (self.To_SelectedCurrency?.coinSymbol)!
                                                    , to_amount: self.sender
                                                    , identifier: "testing out the spending vault dem"
                                                    , transfer_for: "testing out the spending vault dem")
                print(param.description)
                self.trans_model.vaulttransferAPI(param: param) { (status) in
                    if status {
                            self.isPresented.toggle()
                            self.delegate.didselectwithfinalapp(Vaulttype: .animation, connecttype: self.connect_type, tupleobj: [self.trans_model.dataObject.data ?? ""])
                    }
                }
            }
        })
    }
    
    func animation() -> some View {
        ZStack {
            LottieLoader()
                .frame(maxWidth: Screen_width, maxHeight: Screen_width / 1.5, alignment: .bottom)
                .background(BackgroundColor)
        }
        .background(BackgroundColor)
    }
}

struct PopupLottieView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        PopupLottieView(isPresented: $value, plugin_type: .none, connect_type: .none, connectemail: "", trans_model: TransferModel(), delegate: self as! PluginVaultDelegate)
    }
}
