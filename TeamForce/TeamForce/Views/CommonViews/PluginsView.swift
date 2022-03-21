//
//  PluginsView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 31/01/21.
//

import SwiftUI

struct PluginModel {
    var imagename: String
    var index: Int
}

struct PluginsView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var AppVM: AppListModel
    let ListModel: [PluginModel] = [PluginModel.init(imagename: "BlockCheckIC", index: 0)
                                    ,PluginModel.init(imagename: "ConnectIC", index: 1)
                                    ,PluginModel.init(imagename: "SupportIC", index: 2)
                                    ,PluginModel.init(imagename: "MoneyIC", index: 3)
                                    ,PluginModel.init(imagename: "RefreshIC", index: 4)
                                    ,PluginModel.init(imagename: "ChatioIC", index: 5)]
    var delegate: PluginVaultDelegate
    
    
    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(isPresented ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isPresented.toggle()
                    }
                
                VStack (alignment: .center, spacing: 0) {
                    PopupNavView(isnotonelogo: false)
                    if self.AppVM.isLoading {
                        self.listing()
                        self.options()
                    }
                    else {
                        LottieLoader()
                            .frame(maxWidth: Screen_width, maxHeight: Screen_width / 1.5, alignment: .bottom)
                            .background(BackgroundColor)
                    }
                }
                .background(Color.clear)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .onAppear(perform: {
                    AppVM.AppListAPI { (status) in
                        print(AppVM.Applist)
                    }
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .edgesIgnoringSafeArea(.all)
    }
    
    func backAction() -> some View {
        ZStack {
            Button(action: {
                self.isPresented.toggle()
            }) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.all)
        }
        .foregroundColor(Color.clear)
        .background(Color.clear)
    }
    
    func listing() -> some View {
        ZStack {
            List {
                ForEach(self.ListModel, id: \.index) { models in
                    configCell(IMGurl: models.imagename)
                        .tag(models.index)
                        .onTapGesture {
                            self.isPresented.toggle()
                            self.delegate.getpluginevent(index: models.index)
                        }
                }
            }
            .onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().backgroundColor = .clear
                UITableView.appearance().backgroundColor = .clear
            })
            .background(BackgroundColor)
        }
        .background(BackgroundColor)
        .frame(maxWidth: .infinity, maxHeight: Screen_height / 2, alignment: .bottom)
    }
    
    func options() -> some View {
        
        HStack (alignment: .center){
            Button(action: {
                if let url = URL(string: self.AppVM.Applist.logs.first?.iosAppLink ?? "") {
                    UIApplication.shared.open(url)
                    self.isPresented.toggle()
                }
            }) {
                HStack (spacing: 10) {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.custom(MontserratRegularFont, fixedSize: 20))
                        .foregroundColor(Color.white)
                    
                    Text("App Updates")
                        .foregroundColor(Color.white)
                        .font(.custom(MontserratRegularFont, size: 20))
                }
                .padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
        }
        .padding(.bottom, isXseries ? 30 : 10)
        .edgesIgnoringSafeArea(.all)
        .background(OrangeColor)
    }
    
    func configCell(IMGurl: String) -> some View {
        ZStack {
            Button(action: {
                
            }) {
                Image(IMGurl)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 40, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: 75)
            .padding()
            .padding([.leading, .trailing], 15)
            .cornerRadius(10)
            .border(LineColor.opacity(0.3), width: 1)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
}

struct PluginsView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        PluginsView(isPresented: $value, AppVM: AppListModel(), delegate: self as! PluginVaultDelegate)
    }
}
