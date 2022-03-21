//
//  GXUserInfoView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 15/02/21.
//

import SwiftUI

struct GXUserInfoView: View {
    
    @Binding var isPresented: Bool
    @State var vault_type: ConnectOptionType
    @State var connect_type: TransferType
    @State var connectemail: String?
    @ObservedObject var reciepientModel: ReciepientModel
    @ObservedObject var ImageModel: AsyncImageModel
    var delegate: PluginVaultDelegate
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center, spacing: 0) {
                if self.connect_type == .AnotherGX {
                    PopupNavView(isnotonelogo: true, otherlogo: "ConnectIC", BGcolor: OrangeColor)
                        .background(RoundedCorners(color: OrangeColor, tl: 40, tr: 40, bl: 0, br: 0))
                }
                if self.reciepientModel.isLoading {
                    SelectionFlowView()
                        .padding(.bottom, 80)
                        .padding(.top, 20)
                    
                    VStack (alignment: .leading, spacing: 20) {
                        Text("Great News")
                            .font(.custom(MontserratSemiBoldFont, size: 30))
                            .foregroundColor(OrangeColor)
                        
                        Text("We Found A Match. Is This Your Intented Recipient?")
                            .font(.custom(MontserratRegularFont, size: 12))
                            .foregroundColor(TextColor)
                            .padding(.bottom, 50)
                            .opacity(0.5)
                        
                        self.userprofile()
                            .padding(.bottom, 30)
                        
                        Button(action: {
                            self.isPresented.toggle()
                            self.delegate.didselectwithfinalapp(Vaulttype: .news, connecttype: self.connect_type, tupleobj: [])
                        }) {
                            Text("Yes It Is")
                                .foregroundColor(.white)
                                .font(.custom(MontserratRegularFont, size: 16))
                        }
                        .padding()
                        .frame(maxWidth: Screen_width, maxHeight: 50, alignment: .center)
                        .background(OrangeColor)
                        .padding(.bottom, 40)
                        .opacity(self.reciepientModel.isLoading ? 1 : 0.5)
                    }
                    .padding([.leading, .trailing], 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                else {
                    animation()
                        .padding(40)
                }
            }
            .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            self.reciepientModel.reciepientAPI(email: self.connectemail!) { (status) in
                print(self.reciepientModel.dataObject)
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
    
    func userprofile() -> some View {
        HStack (spacing: 25) {
            if self.ImageModel.isLoadingIMG {
                Image(uiImage: self.ImageModel.imageIC.image!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(DarkTextColor, lineWidth: 2))
                    .shadow(radius: 15)
            }
            else {
                Image("ProfileIC")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(DarkTextColor, lineWidth: 2))
                    .shadow(radius: 15)
            }
            
            VStack {
                Text((self.reciepientModel.dataObject.users.first?.userData.name)!)
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 16))
                    .opacity(0.4)
                    .frame(minWidth: Screen_width / 1.5, alignment: .leading)
                
                Text((self.reciepientModel.dataObject.users.first?.userData.email)!)
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 12))
                    .opacity(0.4)
                    .frame(minWidth: Screen_width / 1.5, alignment: .leading)
            }
        }
        .padding()
        .border(LineColor.opacity(0.3), width: 1)
        .onAppear(perform: {
            self.ImageModel.downloadedFrom(link: self.reciepientModel.dataObject.users.first?.userData.profileImg)
        })
    }
}

struct GXUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GXUserInfoView(isPresented: .constant(true), vault_type: .Reciepient, connect_type: .AnotherGX, connectemail: "", reciepientModel: ReciepientModel(), ImageModel: AsyncImageModel(), delegate: self as! PluginVaultDelegate)
    }
}
