//
//  TransferView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 04/02/21.
//

import SwiftUI

struct TransferView: View {
    
    @Binding var isPresented: Bool
    @State var SelectedIndex: TransferType
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
                    
                    PopupNavView()
                    
                    SelectionFlowView()
                        .padding(.bottom, 80)
                        .padding(.top, 20)
                    
                    Text("I Am Transferring")
                        .font(.custom(MontserratSemiBoldFont, size: 30))
                        .foregroundColor(TextColor)
                        .padding(.bottom, 80)
                    
                    self.centeroption()
                        .padding(.bottom, 50)
                    
                }
                .background(RoundedCorners(color: BackgroundColor, tl: 40, tr: 40, bl: 0, br: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            self.SelectedIndex = .none
        })
    }
    
    func centeroption() -> some View {
        VStack (alignment: .center, spacing: 40) {
            Button(action: {
                self.SelectedIndex = .BTvault
            }) {
                HStack (spacing: 5) {
                    Image("VaultsIC")
                    
                    Text("Between My Vaults")
                        .foregroundColor(TextColor)
                        .font(.custom(MontserratRegularFont, size: 16))
                }
                .frame(minWidth: Screen_width / 1.5, alignment: .center)
            }
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            .opacity(self.SelectedIndex == .BTvault ? 1.0 : 0.5)
            
            Button(action: {
                self.SelectedIndex = .AnotherGX
            }) {
                HStack (spacing: 5) {
                    Image("GXUserIC")
                    
                    Text("To Another GX User")
                        .foregroundColor(TextColor)
                        .font(.custom(MontserratRegularFont, size: 16))
                }
                .frame(minWidth: Screen_width / 1.5, alignment: .center)
            }
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            .opacity(self.SelectedIndex == .AnotherGX ? 1.0 : 0.5)
            
            Button(action: {
                self.isPresented.toggle()
                self.delegate.didselecttransferindex(index: self.SelectedIndex)
            }) {
                Text("Proceed To Select Currency")
                    .foregroundColor(Color.white)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .frame(minWidth: Screen_width / 1.5, alignment: .center)
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
            .background(OrangeColor)
            .opacity(self.SelectedIndex == .none ? 0.5 : 1.0)
        }
        .frame(minWidth: Screen_width, alignment: .center)
        .background(BackgroundColor)
        .onAppear {
            self.SelectedIndex = .none
        }
    }
    
}

func topflow(obj: TransferOption) -> some View {
    VStack (alignment: .center, spacing: 0) {
        Image(obj.imagename)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30, alignment: .center)
            .opacity(obj.status ? 1.0 : 0.5)
        
        if obj.index != 1 || obj.index != 3 || obj.index != 5 {
            Text(obj.title)
                .font(.custom(MontserratSemiBoldFont, size: 10))
                .foregroundColor(TextColor)
                .opacity(obj.status ? 1.0 : 0.5)
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        TransferView(isPresented: $value, SelectedIndex: .none, delegate: self as! PluginVaultDelegate)
    }
}
