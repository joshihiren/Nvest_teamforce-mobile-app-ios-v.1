//
//  MenuOptionView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 20/01/21.
//

import SwiftUI

struct MenuOptionView: View {
    
    @Binding var isPresented: Bool
    @State var isLogoutPress: Bool = false
    @ObservedObject var ImageModel: AsyncImageModel
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack (alignment: .center, spacing: 10) {
                self.headernav()
                    .animation(.easeIn)
                
                self.setupprofile()
                    .animation(.easeIn)
                
                Spacer()
                
                self.optionlist()
                    .animation(.easeIn)
                
                Button(action: {
                    self.isLogoutPress.toggle()
                    if self.isLogoutPress {
                        UserInfoData.shared.UserLogout {
                            AppScene.SetLoginVC()
                        }
                    }
                }) {
                    Text("Logout")
                        .font(.custom(MontserratSemiBoldFont, size: 25))
                        .foregroundColor(BackgroundColor)
                        .padding(10)
                }
                .padding(10)
                .padding([.leading, .trailing], 50)
                .background(DarkTextColor)
                .animation(.easeIn)
                
                Rectangle()
                    .foregroundColor(BackgroundColor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .animation(.easeIn)
        }
        .animation(.easeIn)
    }
    
    func headernav() -> some View {
        HStack (alignment: .center) {
            Button(action: {
                self.isPresented.toggle()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(DarkTextColor)
            }
            .padding(10)
            .padding([.top, .leading], 20)
            
            Spacer()
        }
    }
    
    func setupprofile() -> some View {
        VStack (spacing: 30) {
            if self.ImageModel.isLoadingIMG {
                Image(uiImage: self.ImageModel.imageIC.image!)
                    .resizable()
                    .frame(width: Screen_width / 3, height: Screen_width / 3, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(DarkTextColor, lineWidth: 2))
                    .shadow(radius: 10)
            }
            else {
                Image("ProfileIC")
                    .resizable()
                    .frame(width: Screen_width / 3, height: Screen_width / 3, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(DarkTextColor, lineWidth: 2))
                    .shadow(radius: 10)
            }
            
            VStack (spacing: 5) {
                Text("$0.00")
                    .font(.custom(MontserratSemiBoldFont, size: 35))
                    .foregroundColor(DarkTextColor)
                
                Text("Snapay Balance")
                    .font(.custom(MontserratRegularFont, size: 15))
                    .foregroundColor(DarkTextColor)
            }
            
            Rectangle()
                .foregroundColor(BackgroundColor)
        }
        .onAppear(perform: {
            self.ImageModel.downloadedFrom(link: UserInfoData.shared.userinfo(infotype: .profileimg), contentMode: .scaleAspectFit, radious: 0)
        })
    }
    
    func optionlist() -> some View {
        VStack (spacing: 20) {
            Button(action: {
                print("Play tapped")
            }) {
                Text("Play")
                    .font(.custom(MontserratSemiBoldFont, size: 25))
                    .foregroundColor(DarkTextColor)
                    .padding(10)
            }
            .padding(10)
            
            Button(action: {
                print("Train tapped")
            }) {
                Text("Train")
                    .font(.custom(MontserratRegularFont, size: 25))
                    .foregroundColor(DarkTextColor)
                    .padding(10)
            }
            .padding(10)
            
            Button(action: {
                print("Tools tapped")
            }) {
                Text("Tools")
                    .font(.custom(MontserratRegularFont, size: 25))
                    .foregroundColor(DarkTextColor)
                    .padding(10)
            }
            .padding(10)
            
            Button(action: {
                print("Meet tapped")
            }) {
                Text("Meet")
                    .font(.custom(MontserratRegularFont, size: 25))
                    .foregroundColor(DarkTextColor)
                    .padding(10)
            }
            .padding(10)
            
            Spacer()
        }
    }
}

struct MenuOptionView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        MenuOptionView(isPresented: $value, ImageModel: AsyncImageModel())
    }
}
