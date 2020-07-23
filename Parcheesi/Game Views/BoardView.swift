//
//  BoardView.swift
//  Parcheesi
//
//  Created by Ben Munson on 6/24/20.
//

import SwiftUI

let boardRadius: CGFloat = 10.0
let boardBorderColor = Gradient(stops: [.init(color: Color.gray, location: 0.0), .init(color: Color.black, location: 1.0)])
let boardFillColor = Color(.displayP3, white: 0.9, opacity: 1.0)

struct BoardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: boardBorderColor, startPoint: .top, endPoint: .bottom), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
            Rectangle().foregroundColor(boardFillColor)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .padding(20)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView().previewLayout(.fixed(width: 400, height: 400))
    }
}
