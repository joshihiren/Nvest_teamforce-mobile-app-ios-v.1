//
//  ArenaView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import SwiftUI


struct GameTimeView: View {
    
    let colors: [Color] = [.red, .green, .blue, .red, .green, .blue]
    @State var showing: Bool
    var delegate: PluginVaultDelegate
    
    var body: some View {
        ZStack {
            List {
                self.topview()
                
                self.livegame()
                
                self.recentgame()
            }
            .onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
                   UITableViewCell.appearance().backgroundColor = .clear
                   UITableView.appearance().backgroundColor = .clear
            })
//            .sheet(isPresented: self.$showing) {
//                Color.black.opacity(0.7)
//                                .background(BackgroundClearView())
//                CurrentSessionView()
//            }
        }
    }
    
    // MARK:- Setup GameTime View
    // MARK:-
    
    func topview() -> some View {
        HStack {
            Text("GAMETIME")
                .font(.custom(MontserratBoldFont, size: 26))
                .foregroundColor(OrangeColor)
            
            Spacer()
            
            Button(action: {
                print("Create pressed")
            }) {
                Text("+ New")
                    .foregroundColor(TextColor)
                    .font(.custom(MontserratRegularFont, size: 16))
            }
            .padding()
            .border(LineColor.opacity(0.3), width: 1)
        }
        .padding()
    }
    
    func livegame() -> some View {
        VStack (alignment: .leading) {
            
            Text("Live Games")
                .font(.custom(MontserratBoldFont, size: 26))
                .foregroundColor(OrangeColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    ForEach(colors, id: \.self) { color in
                        self.livegamecell()
                            .onTapGesture {
//                                self.showing.toggle()
                                self.delegate.didselectgamecell(gameobj: color)
                            }
                            .padding()
                    }
                    .border(LineColor.opacity(0.3), width: 1)
                }
            }
            .padding()
        }
    }
    
    func livegamecell() -> some View {
        VStack {
            Text("Cell")
        }
        .frame(width: Screen_width / 2.5, height: 100, alignment: .center)
    }
    
    func recentgame() -> some View {
        VStack (alignment: .leading) {
            
            Text("Recent Games")
                .font(.custom(MontserratBoldFont, size: 26))
                .foregroundColor(OrangeColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ForEach(colors, id: \.self) { color in
                self.recentcell()
                    .padding()
            }
            .border(LineColor.opacity(0.3), width: 1)
            .padding()
        }
    }
    
    func recentcell() -> some View {
        VStack {
            Text("Cell")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        
    }
    
    // MARK:- Setup CurrentSession View
    // MARK:-
    
}

struct GameTimeView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        GameTimeView(showing: value, delegate: self as! PluginVaultDelegate)
    }
}
