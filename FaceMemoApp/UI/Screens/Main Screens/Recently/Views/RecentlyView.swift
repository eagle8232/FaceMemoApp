//
//  RecentlyView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

import _AVKit_SwiftUI

struct RecentlyView: View {
    @EnvironmentObject var storageVM: StorageViewModel
    @State var currentDescriptionText: String = ""
    @State var selectedImageModel: ImageModel?
    
    @State var isEditing: Bool = false
    @State var selectedImageModels: [ImageModel] = []
    
    var body: some View {
        ZStack {
            contentView
            alertView
            deleteButtonView
        }
    }
    
    var contentView: some View {
        VStack(alignment: .leading) {
            // Heading
            VStack {
                HStack {
                    Text("Recently Captured")
                        .font(.system(size: 25, weight: .bold))
                    Spacer()
                    CustomButton(style: .rounded(isEditing ? "Done" : "Edit", nil)) {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
                videoBannerView
            }
            .padding()
            
            // List View
            ImagesListView(isEditing: $isEditing, selectedImageModels: $selectedImageModels, imageModels: storageVM.imageModels) { imageModel in
                self.selectedImageModel = imageModel
            } deleteImageModel: { imageModel in
                withAnimation {
                    storageVM.deleteImageModelAt(imageModel)
                }
            }
        }
    }
    
    var alertView: some View {
        ZStack {
            if let selectedImageModel {
                CustomAlertView(title: "Description", message: "Create a memorable description for this picture", alertType: .saveDescription, descriptionText: selectedImageModel.description ?? "") {
                    self.selectedImageModel = nil
                } submitText: { text in
                    storageVM.saveDescription(for: selectedImageModel, text: text)
                    self.selectedImageModel = nil /// - After saving it, we need to set it to nil
                }
            }
        }
    }
    
    var deleteButtonView: some View {
        VStack(alignment: .trailing) {
            if isEditing {
                Spacer()
                CustomButton(style: .circled(nil, Image(systemName: "trash")), size: 30) {
                    storageVM.deleteSelectedImageModels(selectedImageModels)
                    withAnimation {
                        isEditing = false /// - After deleting image models, set 'isEditing' to false, as it is better for UX
                    }
                }
            }
        }
        .padding()
        .padding(.bottom, Constants.bottomPaddingSize + 80)
    }
    
    // MARK: - Markeding Banner Ads
    var marketingRepository: MarketingRepository = MarketingRepository()
    
    @State private var splashVideoString: String?
    @State private var splashUrlString: String?
    @State private var player: AVPlayer?
    
    var videoBannerView: some View {
        ZStack {
            if splashVideoString != nil {
                VideoPlayer(player: player)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
                    .onAppear {
                        self.player = AVPlayer(url: URL(string: splashVideoString ?? "")!)
                        self.player?.play()
                        UIViewController.attemptRotationToDeviceOrientation()
                    }
                    .onDisappear {
                        self.player?.pause()
                        self.player = nil
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white.opacity(0.1))
                    .frame(height: 200)
                    .onTapGesture {
                        if let urlString = splashUrlString, let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    }
            }
        }
        .padding(.horizontal)
        .onAppear {
            Task {
                await marketingRepository.getVideoAds { data in
                    self.splashUrlString = data?.url
                    self.splashVideoString = data?.fileLink
                    guard let url = URL(string: self.splashVideoString ?? "") else {return}
                    self.player = AVPlayer(url: url)
                }
            }
        }
    }
    
}

#Preview {
    RecentlyView()
}
