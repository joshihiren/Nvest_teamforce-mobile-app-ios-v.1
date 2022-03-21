//
//  CurrentSessionVIew.swift
//  TeamForce
//
//  Created by Hiren Joshi on 26/01/21.
//

import SwiftUI

struct CurrentSessionView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(isPresented ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isPresented.toggle()
                }
            
            VStack (alignment: .center, spacing: 0) {
                self.header()
                
                self.minutes()
                    .padding(.bottom)
                
                self.earning()
                
                self.options()
            }
            .frame(alignment: .bottom)
            .edgesIgnoringSafeArea(.all)
            .background(BackgroundColor)
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        .offset(x: 0, y: 0)
    }
    
    func backAction() -> some View {
        ZStack {
            Button(action: {
                
            }) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(Color.clear)
        }
    }
    
    func header() -> some View {
        HStack {
            Text("Current Session")
                .font(.custom(MontserratRegularFont, size: 20))
                .foregroundColor(Color.white)
            
            Spacer()
            
            Text("3.45 Hrs.")
                .font(.custom(MontserratRegularFont, size: 20))
                .foregroundColor(Color.white)
        }
        .padding()
        .background(OrangeColor)
    }
    
    func minutes() -> some View {
        VStack () {
            HStack {
                Text("Minutes")
                    .font(.custom(MontserratSemiBoldFont, size: 23))
                    .foregroundColor(TextColor)
                    .padding()
                
                Spacer()
            }
            
            HStack {
                Text("Checked In ")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
                
                Spacer()
                
                Text("9:35 AM IST")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
            }
            .padding()
            
            HStack {
                Text("Checked Out")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
                
                Spacer()
                
                Text("2:35 PM IST")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
            }
            .padding()
            
            HStack {
                Text("Checked In ")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
                
                Spacer()
                
                Text("4:03 PM IST")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
            }
            .padding()
            
        }
    }
    
    func earning() -> some View {
        VStack () {
            HStack {
                Text("Earnings")
                    .font(.custom(MontserratSemiBoldFont, size: 23))
                    .foregroundColor(TextColor)
                    .padding()
                
                Spacer()
            }
            
            HStack {
                Text("Gross")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
                
                Spacer()
                
                Text("$135.25 USD")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(GreenColor)
            }
            .padding()
            
            HStack {
                Text("Bonuses")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
                
                Spacer()
                
                Text("$42.26 USD")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(GreenColor)
            }
            .padding()
            
            HStack {
                Text("Deductions")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(TextColor)
                
                Spacer()
                
                Text("$25.25 USD")
                    .font(.custom(MontserratRegularFont, size: 14))
                    .foregroundColor(OrangeColor)
            }
            .padding()
            
        }
    }
    
    func options() -> some View {
        HStack (alignment: .center, spacing: 20){
            Button(action: {
                
            }) {
                HStack (spacing: 5) {
                    Image("PayslipIC")
                    
                    Text("PaySlip")
                        .foregroundColor(TextColor)
                        .font(.custom(MontserratRegularFont, size: 16))
                }
            }
            .padding()
            .padding([.leading, .trailing], 15)
            .border(LineColor.opacity(0.3), width: 1)
            
            Button(action: {
                
            }) {
                HStack (spacing: 5) {
                    Image("CheckoutIC")
                    Text("Check Out")
                        .foregroundColor(TextColor)
                        .font(.custom(MontserratRegularFont, size: 16))
                }
            }
            .padding()
            .padding([.leading, .trailing], 15)
            .border(LineColor.opacity(0.3), width: 1)
        }
        .padding()
        .padding(.bottom, 30)
    }
    
}

struct CurrentSessionView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        CurrentSessionView(isPresented: $value)
    }
}
