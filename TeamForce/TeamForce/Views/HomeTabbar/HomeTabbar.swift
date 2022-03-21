//
//  HomeTabbar.swift
//  TeamForce
//
//  Created by Hiren Joshi on 18/01/21.
//

import SwiftUI

enum PluginType {
    case none
    case blockchecks
    case connects
    case supports
    case moneymarkets
    case refreshes
    case chatio
}

enum TransferType {
    case none
    case BTvault
    case AnotherGX
}

enum ConnectOptionType {
    case none
    case fromapp
    case fromcurrency
    case toapp
    case tocurrency
    case Reciepient
    case news
    case amount
    case animation
    case complete
}

protocol PluginVaultDelegate {
    func getpluginevent(index: Int)
    func didselecttransferindex(index: TransferType)
    func didselectwithfinalapp(Vaulttype: ConnectOptionType, connecttype: TransferType, tupleobj: [Any])
    func didselectgamecell(gameobj: Any)
}

struct HomeTabbar: View, PluginVaultDelegate {
    
    @State private var value = false
    @State private var showingConnect = true
    @State private var isSourceapp = true
    @State private var isSourcecurrency = true
    @State private var isDestinationapp = true
    @State private var isDestinationcurrency = true
    @State private var isAmount = true
    @State private var isAnimation = true
    @State private var isReciepient = true
    @State private var isnews = true
    @State private var isComplete = true
    @State var index = 0
    @State var isPlugin: Bool
    @State var plugin_type: PluginType
    @State var connect_type: TransferType
    @State var vault_type: ConnectOptionType
    @State private var Vaultdatas: (connectemail: String?, FromApps: [RegisterAppUserApp]?, FromSelectedApp: RegisterAppUserApp?, FromCurrencies: [CurrencyCoinsData]?, FromSelectedCurrency: CurrencyCoinsData?, ToSelectedApp: RegisterAppUserApp?, ToSelectedCurrency: CurrencyCoinsData?, sending: Double?, recieving: Double?)
    
    var body: some View {
        ZStack {
            VStack {
                NavHeaderView(showing: false) { (status) in
                    self.isPlugin = true
                }
                
                ZStack {
                    if self.index == 0 {
                        GameTimeView(showing: self.value, delegate: self)
                    }
                    else if self.index == 1 {
                        FitnessView()
                    }
                    else if self.index == 2 {
                        RedHeartView()
                    }
                    else if self.index == 3 {
                        TimerView()
                    }
                    else {
                        ProfileView()
                    }
                }
                TabBar(index: $index)
            }
            .animation(.default)
            .navigationBarHidden(true)
            .navigationBarTitle("")
            
            if self.isPlugin {
                PluginsView(isPresented: self.$isPlugin, AppVM: AppListModel(), delegate: self)
            }
            if self.plugin_type == .connects {
                TransferView(isPresented: self.$showingConnect, SelectedIndex: .none, delegate: self)
            }
            
            if self.vault_type == .fromapp {
                ConnectFromAppView(isPresented: self.$isSourceapp
                                   , vault_type: self.vault_type
                                   , connect_type: self.connect_type
                                   , connectemail: self.Vaultdatas.connectemail
                                   , ImageModel: AsyncImageModel()
                                   , delegate: self)
            }
            else if self.vault_type == .fromcurrency {
                ConnectFromCurrencyView(isPresented: self.$isSourcecurrency
                                        , vault_type: self.vault_type
                                        , connect_type: self.connect_type
                                        , connectemail: self.Vaultdatas.connectemail
                                        , From_Apps: self.Vaultdatas.FromApps
                                        , From_SelectedApp: self.Vaultdatas.FromSelectedApp
                                        , ImageModel: AsyncImageModel()
                                        , delegate: self)
            }
            else if self.vault_type == .toapp {
                ConnectToAppView(isPresented: self.$isDestinationapp
                                 , vault_type: self.vault_type
                                 , connect_type: self.connect_type
                                 , connectemail: self.Vaultdatas.connectemail
                                 , ImageModel: AsyncImageModel()
                                 , From_Apps: self.Vaultdatas.FromApps
                                 , From_SelectedApp: self.Vaultdatas.FromSelectedApp
                                 , From_Currencies: self.Vaultdatas.FromCurrencies
                                 , From_SelectedCurrency: self.Vaultdatas.FromSelectedCurrency
                                 , delegate: self)
            }
            else if self.vault_type == .tocurrency {
                ConnectToCurrencyView(isPresented: self.$isDestinationcurrency
                                      , vault_type: self.vault_type
                                      , connect_type: self.connect_type
                                      , connectemail: self.Vaultdatas.connectemail
                                      , From_Apps: self.Vaultdatas.FromApps
                                      , From_SelectedApp: self.Vaultdatas.FromSelectedApp
                                      , From_Currencies: self.Vaultdatas.FromCurrencies
                                      , From_SelectedCurrency: self.Vaultdatas.FromSelectedCurrency
                                      , To_SelectedApp: self.Vaultdatas.ToSelectedApp
                                      , ImageModel: AsyncImageModel()
                                      , delegate: self)
            }
            else if self.vault_type == .amount {
                ConnectAmountView(isPresented: self.$isAmount
                                  , plugin_type: self.plugin_type
                                  , connect_type: self.connect_type
                                  , connectemail: self.Vaultdatas.connectemail
                                  , From_SelectedApp: self.Vaultdatas.FromSelectedApp
                                  , From_Currencies: self.Vaultdatas.FromCurrencies
                                  , From_SelectedCurrency: self.Vaultdatas.FromSelectedCurrency
                                  , To_SelectedApp: self.Vaultdatas.ToSelectedApp
                                  , To_SelectedCurrency: self.Vaultdatas.ToSelectedCurrency
                                  , delegate: self
                                  , ImageModel: AsyncImageModel())
                    .environmentObject(AmountItem())
            }
            else if self.vault_type == .animation {
                PopupLottieView(isPresented: self.$isAnimation
                                , plugin_type: self.plugin_type
                                , connect_type: self.connect_type
                                , connectemail: self.Vaultdatas.connectemail
                                , trans_model: TransferModel()
                                , From_SelectedApp: self.Vaultdatas.FromSelectedApp
                                , From_Currencies: self.Vaultdatas.FromCurrencies
                                , From_SelectedCurrency: self.Vaultdatas.FromSelectedCurrency
                                , To_SelectedApp: self.Vaultdatas.ToSelectedApp
                                , To_SelectedCurrency: self.Vaultdatas.ToSelectedCurrency
                                , sender: self.Vaultdatas.sending
                                , reciever: self.Vaultdatas.recieving
                                , delegate: self)
            }
            else if self.vault_type == .complete {
                ConnectCompleteView(isPresented: self.$isComplete
                                    , plugin_type: self.plugin_type
                                    , connect_type: self.connect_type
                                    , connectemail: self.Vaultdatas.connectemail
                                    , From_Apps: self.Vaultdatas.FromApps
                                    , From_SelectedApp: self.Vaultdatas.FromSelectedApp
                                    , From_Currencies: self.Vaultdatas.FromCurrencies
                                    , From_SelectedCurrency: self.Vaultdatas.FromSelectedCurrency
                                    , To_SelectedApp: self.Vaultdatas.ToSelectedApp
                                    , To_SelectedCurrency: self.Vaultdatas.ToSelectedCurrency
                                    , sender: self.Vaultdatas.sending
                                    , reciever: self.Vaultdatas.recieving
                                    , ImageModel: AsyncImageModel()
                                    , delegate: self)
            }
            else if self.vault_type == .Reciepient {
                ReciepientView(isPresented: self.$isReciepient
                               , vault_type: self.vault_type
                               , connect_type: self.connect_type
                               , connectemail: self.Vaultdatas.connectemail
                               , delegate: self)
                    .environmentObject(ReciepientItem())
            }
            else if self.vault_type == .news {
                GXUserInfoView(isPresented: self.$isnews
                               , vault_type: self.vault_type
                               , connect_type: self.connect_type
                               , connectemail: self.Vaultdatas.connectemail
                               , reciepientModel: ReciepientModel()
                               , ImageModel: AsyncImageModel()
                               , delegate: self)
            }
            else {
                
            }
        }
    }
    
    // MARK:- Define Delegate methods
    // MARK:-
    
    func getpluginevent(index: Int) {
        self.showingConnect = true
        self.plugin_type = index == 0 ? .blockchecks : index == 1 ? .connects : index == 2 ? .supports : index == 3 ? .moneymarkets : index == 4 ? .refreshes : index == 5 ? .chatio : .none
    }
    
    func didselecttransferindex(index: TransferType)  {
        self.isSourceapp = true
        self.connect_type = index
        self.Vaultdatas.connectemail = UserInfoData.shared.userinfo(infotype: .email)
        self.vault_type = .fromapp
    }
    
    func didselectwithfinalapp(Vaulttype: ConnectOptionType, connecttype: TransferType, tupleobj: [Any]) {
        self.connect_type = connecttype
        if Vaulttype == .fromapp {
            self.isSourceapp = true
            self.vault_type = .fromcurrency
            self.Vaultdatas.FromApps = tupleobj.first as! [RegisterAppUserApp]?
            self.Vaultdatas.FromSelectedApp = tupleobj.last as! RegisterAppUserApp?
        }
        else if Vaulttype == .fromcurrency {
            self.isSourcecurrency = true
            self.vault_type = self.connect_type == .BTvault ? .toapp : .Reciepient
            self.Vaultdatas.FromCurrencies = tupleobj.first as! [CurrencyCoinsData]?
            self.Vaultdatas.FromSelectedCurrency = tupleobj.last as! CurrencyCoinsData?
        }
        else if Vaulttype == .toapp {
            self.isDestinationapp = true
            self.vault_type = .tocurrency
            self.Vaultdatas.ToSelectedApp = tupleobj.first as! RegisterAppUserApp?
        }
        else if Vaulttype == .tocurrency {
            self.isDestinationcurrency = true
            self.vault_type = .amount
            self.Vaultdatas.ToSelectedCurrency = tupleobj.first as! CurrencyCoinsData?
        }
        else if Vaulttype == .amount {
            self.isAmount = true
            self.vault_type = .animation
            self.Vaultdatas.sending = NumberFormatter().number(from: tupleobj.first as! String)?.doubleValue
            self.Vaultdatas.recieving = NumberFormatter().number(from: tupleobj.last as! String)?.doubleValue
        }
        else if Vaulttype == .animation {
            self.isAnimation = true
            self.vault_type = .complete
        }
        else if Vaulttype == .complete {
            self.isComplete = false
            self.vault_type = .none
            self.connect_type = .none
        }
        else if Vaulttype == .Reciepient {
            self.vault_type = .news
            self.isReciepient = true
            self.Vaultdatas.connectemail = tupleobj.first as? String
        }
        else if Vaulttype == .news {
            self.vault_type = .toapp
            self.isnews = true
        }
        else {
            self.vault_type = .none
        }
    }
    
    func didselectgamecell(gameobj: Any) {
        //        CurrentSessionView(isPresented: .constant(true))
    }
}

struct TabBar: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack (alignment: .center, spacing: 20) {
            VStack {
                Image("ArenaIC")
                    .resizable()
                    .frame(width: 20, height: 20)
                if self.index == 0 {
                    Text("Arena")
                        .font(.custom(MontserratRegularFont, size: 12))
                }
            }
            .padding(15)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 0
            }
            
            VStack {
                Image("FitnessIC")
                    .resizable()
                    .frame(width: 20, height: 20)
                if self.index == 1 {
                    Text("Fitness")
                        .font(.custom(MontserratRegularFont, size: 12))
                }
            }
            .padding(15)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 1
            }
            
            VStack {
                Image("RedHeartIC")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding(15)
            .background(self.index == 2 ? OrangeColor : OrangeColor.opacity(0.7))
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 2
            }
            
            VStack {
                Image("TimerIC")
                    .resizable()
                    .frame(width: 20, height: 20)
                if self.index == 3 {
                    Text("Timer")
                        .font(.custom(MontserratRegularFont, size: 12))
                }
            }
            .padding(15)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 3
            }
            
            VStack {
                Image("ProfileIC")
                    .resizable()
                    .frame(width: 20, height: 20)
                if self.index == 4 {
                    Text("Profile")
                        .font(.custom(MontserratRegularFont, size: 12))
                }
            }
            .padding(15)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 4
            }
        }
        .frame(maxWidth: Screen_width, maxHeight: 50)
        .background(BackgroundColor)
        .animation(.default)
    }
}

struct HomeTabbar_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabbar(index: 0, isPlugin: false, plugin_type: .none, connect_type: .none, vault_type: .none)
    }
}
