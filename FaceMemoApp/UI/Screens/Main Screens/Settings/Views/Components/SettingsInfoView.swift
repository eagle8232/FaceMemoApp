//
//  SettingsInfoView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import SwiftUI

struct SettingsInfoView: View {
    let title: String
    let text: String 
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(text)
                .font(.system(size: 15, weight: .regular))
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
