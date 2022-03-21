//
//  ConnectListPopupView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 12/02/21.
//

import SwiftUI

protocol ConnectListPopupDelegate {
    func didselectcell(type: ConnectListtype, connecttype: TransferType, tupleobj: [Any])
}

enum ConnectListtype {
    case app
    case coin
    case none
}

class connectpopItem: ObservableObject {
    @Published var searchtext: String = ""
}

struct ConnectListPopupView: View {
    
    var title: String? = "All Your Apps"
    var lefttitle: String? = "With Balances"
    var righttitle: String? = "All Apps"
    var email: String?
    var appcode: String?
    var profileid: String?
    
    @Binding var isPresented: Bool
    @State var type: ConnectListtype
    @State var connect_type: TransferType
    @State var vault_type: ConnectOptionType
    @ObservedObject var ImageModel: AsyncImageModel
    @ObservedObject var coinmodel: CurrencyTypeModel
    @ObservedObject var appmodel: SelectedAppModel
    var delegate: ConnectListPopupDelegate
    
    @EnvironmentObject private var item: connectpopItem
    @State private var searchbar = FieldChecker()
    @State private var applist_arry: [RegisterAppUserApp]?
    @State private var coinlist_arry: [CurrencyCoinsData]?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isPresented.toggle()
                }
            
            VStack (alignment: .center, spacing: 20) {
                if self.appmodel.isLoading || self.coinmodel.isLoading {
                    Text(self.title!)
                        .foregroundColor(Color.white)
                        .font(.custom(MontserratRegularFont, size: 20))
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                        .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                    
                    self.search_bar()
                        .foregroundColor(TextColor)
                        .font(.custom(MontserratRegularFont, size: 15))
                        .padding()
                        .border(LineColor.opacity(0.3), width: 1)
                        .padding([.leading, .trailing], 30)
                    
                    List {
                        if self.type == .app {
                            ForEach(self.applist_arry!, id: \.profileId) { App in
                                self.configappCell(obj: App)
                                    .onTapGesture {
                                        self.isPresented.toggle()
                                        self.delegate.didselectcell(type: self.type, connecttype: self.connect_type, tupleobj: [self.appmodel.dataObject.userApps as Any, App])
                                    }
                            }
                        }
                        else if self.type == .coin {
                            ForEach(self.coinlist_arry!, id: \.id) { coin in
                                self.configcoinCell(obj: coin)
                                    .onTapGesture {
                                            self.isPresented.toggle()
                                            self.delegate.didselectcell(type: self.type, connecttype: self.connect_type, tupleobj: [self.coinmodel.dataObject.coinsData as Any, coin])
                                    }
                            }
                        }
                    }
                    .onAppear(perform: {
                        UITableView.appearance().separatorStyle = .none
                        UITableViewCell.appearance().backgroundColor = .clear
                        UITableView.appearance().backgroundColor = .clear
                    })
                    .frame(maxWidth: Screen_width / 1.5, maxHeight: Screen_height / 2, alignment: .center)
                    .padding(.bottom, 20)
                        
                    self.optionview()
                }
                else {
                    LottieLoader()
                        .frame(maxWidth: Screen_width, maxHeight: Screen_width / 1.5, alignment: .bottom)
                        .background(RoundedCorners(color: BackgroundColor, tl: 20, tr: 20, bl: 20, br: 20))
                }
            }
            .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 20, br: 20))
            .frame(maxWidth: .infinity, maxHeight: Screen_height / 2 + 100, alignment: .center)
            .padding([.leading, .trailing], 30)
            .onAppear(perform: {
                if self.type == .app {
                    self.appmodel.selectedApplist(email: self.email!) { (status) in
                        self.applist_arry = self.appmodel.dataObject.userApps
                    }
                }
                else if self.type == .coin {
                    self.coinmodel.getcurrencylist(appcode: self.appcode!, appprofile: self.profileid!) { (status) in
                        self.coinlist_arry = self.coinmodel.dataObject.coinsData
                    }
                }
            })
        }
        .keyboardAdaptive()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    func search_bar() -> some View {
        TextFieldWithValidator(title: "Search Your Apps With Balances",
                               value: $item.searchtext,
                               checker: $searchbar,
                               onCommit: filter) { v in
            self.filterdata(str: v)
            return nil
        }
        .animation(.easeIn)
        .autocapitalization(.none)
    }
    
    func filterdata(str: String) {
        if self.type == .app || self.searchbar.valid {
            if str.isEmpty {
                self.applist_arry = self.appmodel.dataObject.userApps
            }
            else {
                self.applist_arry = self.appmodel.dataObject.userApps.filter({ (obj) -> Bool in
                    return (obj.appName.uppercased().contains(str.uppercased())) || (obj.appCode.uppercased().contains(str.uppercased()))
                })
            }
        }
        else if self.type == .coin || self.searchbar.valid  {
            if str.isEmpty {
                self.coinlist_arry = self.coinmodel.dataObject.coinsData
            }
            else {
                self.coinlist_arry = self.coinmodel.dataObject.coinsData.filter({ (obj) -> Bool in
                    return (obj.coinName.uppercased().contains(str.uppercased())) || (obj.coinSymbol.uppercased().contains(str.uppercased()))
                })
            }
        }
    }
    
    func filter() { }
    
    func optionview() -> some View {
        HStack (alignment: .center, spacing: 0) {
            
            Button(action: {
                
            }) {
                Text(self.lefttitle!)
                    .foregroundColor(OrangeColor)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .padding()
            .frame(maxWidth: Screen_width, maxHeight: 50, alignment: .center)
            .border(LineColor, width: 1)
            
            Button(action: {
                
            }) {
                Text(self.righttitle!)
                    .foregroundColor(.white)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .padding()
            .frame(maxWidth: Screen_width, maxHeight: 50, alignment: .center)
            .background(OrangeColor)
        }
        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
    }
    
    func configcoinCell(obj: CurrencyCoinsData) -> some View {
        
        HStack (spacing: 5) {
            if self.ImageModel.isLoadingIMG {
                Image(uiImage: self.ImageModel.imageIC.image!)
                    .resizable()
                    .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
            }
            
            Text(obj.coinName)
                .foregroundColor(TextColor)
                .font(.custom(MontserratRegularFont, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(String.init(format: "%f", obj.usdPrice).CoinPriceThumbRules(Coin: obj.coinSymbol)!)
                .foregroundColor(TextColor)
                .font(.custom(MontserratRegularFont, size: 12))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: 75)
        .onAppear(perform: {
            self.ImageModel.downloadedFrom(link: obj.coinImage)
        })
    }
    
    func configappCell(obj: RegisterAppUserApp) -> some View {
        HStack (spacing: 5) {
            if self.ImageModel.isLoadingIMG {
                Image(uiImage: self.ImageModel.imageIC.image!)
                    .resizable()
                    .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
            }
            
            Text(obj.appName)
                .foregroundColor(TextColor)
                .font(.custom(MontserratRegularFont, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: 75)
        .onAppear(perform: {
            self.ImageModel.downloadedFrom(link: obj.appIcon)
        })
    }
    
}

struct ConnectListPopupView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ConnectListPopupView(isPresented: $value, type: .none, connect_type: .none, vault_type: .none, ImageModel: AsyncImageModel(), coinmodel: CurrencyTypeModel(), appmodel: SelectedAppModel(), delegate: self as! ConnectListPopupDelegate)
            .environmentObject(connectpopItem())
    }
}
