//
//  PopupNavView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 04/02/21.
//

import SwiftUI

struct PopupNavView: View {
    
    var isnotonelogo: Bool = false
    var otherlogo: String = ""
    var BGcolor: Color = BackgroundColor
    
    var body: some View {
        VStack {
            HStack (alignment: .center, spacing: 10) {
                if isnotonelogo {
                    Image.init(self.otherlogo)
                        .resizable()
//                        .renderingMode(.original)
                        .frame(maxWidth: Screen_width / 2, maxHeight: 30, alignment: .center)
                        .padding([.top, .bottom], 15)
                        .foregroundColor(Color.white)
                }
                else {
                    Image.init("TeamForce_LOGO")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding([.top, .bottom], 15)
                    
                    Image.init("TeamForce_Text")
                        .resizable()
                        .frame(width: 150, height: 30, alignment: .center)
                        .padding([.top, .bottom], 15)
                }
            }
            Divider()
        }
        .background(RoundedCorners(color: BGcolor, tl: 40, tr: 40, bl: 0, br: 0))
    }
}

struct PopupNavView_Previews: PreviewProvider {
    static var previews: some View {
        PopupNavView()
    }
}
