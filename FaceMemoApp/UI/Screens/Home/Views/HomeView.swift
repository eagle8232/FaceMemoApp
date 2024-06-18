//
//  HomeView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import StreamVideoSwiftUI
import StreamVideo

struct HomeView: View {
    
    var body: some View {
        ZStack {
            CameraView()
        }
    }
    
}

#Preview {
    HomeView()
}
