//
//  SelectionFlowView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 05/02/21.
//

import SwiftUI

struct TransferOption {
    var imagename: String
    var title: String
    var status: Bool
    var index: Int
}

struct SelectionFlowView: View {
    
    let optionflow: [TransferOption] = [TransferOption.init(imagename: "SendCurrencyIC", title: "Send Currency", status: true, index: 0)
                                        ,TransferOption.init(imagename: "ForwaredIC", title: "", status: false, index: 1)
                                        ,TransferOption.init(imagename: "ToCurrencyIC", title: "To Currency", status: false, index: 2)
                                        ,TransferOption.init(imagename: "ForwaredIC", title: "", status: false, index: 3)
                                        ,TransferOption.init(imagename: "ReciepientIC", title: "Reciepient", status: false, index: 4)
                                        ,TransferOption.init(imagename: "ForwaredIC", title: "", status: false, index: 5)
                                        ,TransferOption.init(imagename: "AmountIC", title: "Amount", status: false, index: 6)]
    
    var body: some View {
        HStack (alignment: .center, spacing: 10) {
            ForEach(self.optionflow, id: \.index) { models in
                topflow(obj: models)
                    .onTapGesture {
                        print(models.index)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(BackgroundColor)
    }
}

struct SelectionFlowView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionFlowView()
    }
}
