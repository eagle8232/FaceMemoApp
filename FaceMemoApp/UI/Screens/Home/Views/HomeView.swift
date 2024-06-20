//
//  HomeView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            CameraView { imageModel in
                guard let imageModel else { return }
                homeVM.images.append(imageModel)
                homeVM.saveImages()
            }
        }
    }
    
}

