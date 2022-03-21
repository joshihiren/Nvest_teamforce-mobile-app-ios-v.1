//
//  NavHeaderView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import SwiftUI

struct NavHeaderView: View {
    
    @State var showing: Bool
    let Showplugin: ((_ status: Bool) -> Void)?
    
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .center) {
                Button(action: {
                    self.showing = true
                }) {
                    Image("MenuIC")
                }
                .padding()
                .padding([.leading, .trailing], 5)
                .sheet(isPresented: self.$showing) {
                    MenuOptionView(isPresented: self.$showing, ImageModel: AsyncImageModel())
                }
                Rectangle()
                    .foregroundColor(Color.clear)
                
                Image("NavIcon")
                    .frame(alignment: .center)
                
                Rectangle()
                    .foregroundColor(Color.clear)
                
                Button(action: {
                    self.Showplugin!(true)
                }) {
                    Image("PlanIC")
                }
                .padding()
                .padding([.leading, .trailing], 5)
                .frame(alignment: .trailing)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Divider()
        }
        .frame(maxWidth: .infinity, maxHeight: 77, alignment: .topLeading)
    }
}

struct NavHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavHeaderView(showing: false) { (status) in
            
        }
    }
}
