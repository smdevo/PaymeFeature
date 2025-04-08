//
//  HeadLineView.swift
//  PaymeFeature
//
//  Created by Samandar on 08/04/25.
//

import SwiftUI

struct HeadLineView: View {
    
    let title: String
    let isOn: Bool
    
    init(title: String, isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)


            Rectangle()
                .fill(isOn ?  Color.paymeC : .clear)
                .frame(height: .spacing(.x2))
        }
    }
}

#Preview {
    HeadLineView(title: "Kartalar", isOn: true)
}
