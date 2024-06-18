//
//  DeepARViewController.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import UIKit
import DeepAR

class DeepARViewController: UIViewController, DeepARDelegate {
    var effect: DeepAREffect?
    var deepAR: DeepAR!
    var cameraController: CameraController?
    
    init(effect: DeepAREffect?) {
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
        
        /// - Initialize and start camera controller
        cameraController = CameraController()
        cameraController?.deepAR = deepAR
        cameraController?.startCamera(withAudio: true)
        
        /// - Load a filter
        switchEffect(effect: effect)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cameraController {
            cameraController.startCamera()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cameraController?.stopCamera()
        
    }
    
    func switchEffect(effect: DeepAREffect?) {
        if let path = effect?.path {
            deepAR.switchEffect(withSlot: "effect", path: path)
        }
    }
}
