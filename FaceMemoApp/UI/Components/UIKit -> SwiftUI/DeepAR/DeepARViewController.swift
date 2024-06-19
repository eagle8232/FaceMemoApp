//
//  DeepARViewController.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import UIKit
import DeepAR
import PhotosUI

class DeepARViewController: UIViewController, DeepARDelegate {
    var cameraManager: CameraManager
    var effect: DeepAREffect
    var deepAR: DeepAR!
    var cameraController: CameraController!
    
    init(cameraManager: CameraManager, effect: DeepAREffect) {
        self.cameraManager = cameraManager
        self.effect = effect
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// - Initialize DeepAR
        deepAR = DeepAR()
        deepAR.delegate = self
        self.deepAR.setLicenseKey(Constants.deepARLicenseKey)
        
        /// - Create ARView
        guard let arView = deepAR.createARView(withFrame: self.view.bounds) else { return }
        arView.translatesAutoresizingMaskIntoConstraints = false
        
        /// - Add ARView to the view hierarchy
        view.addSubview(arView)
        NSLayoutConstraint.activate([
            arView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        /// - We give a value to deepAR to capture photos with effects
        cameraManager.deepAR = deepAR
        
        cameraController = CameraController()
        cameraController?.deepAR = deepAR
        self.deepAR.videoRecordingWarmupEnabled = true
        
        /// - Load a filter
        switchEffect(effect: effect)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraController?.stopCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraController?.startCamera(withAudio: true)
    }
    
    func switchEffect(effect: DeepAREffect?) {
        if let path = effect?.path {
            deepAR.switchEffect(withSlot: "effect", path: path)
        }
    }
    
    
    
    func didInitialize() {
        print("didInitialize")
    }
    
    
}
