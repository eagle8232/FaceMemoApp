//
//  DeepAREffect.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

enum DeepAREffect: String, CaseIterable {
    case EmotionMeter = "Emotion_Meter"
    case EmotionsExaggerator = "Emotions_Exaggerator"
    case FireEffect = "Fire_Effect"
    case FlowerFace = "flower_face"
    case GalaxyBackground = "galaxy_background"
    case Hope = "Hope"
    case MakeupLook = "MakeupLook"
    case NeonDevilHorns = "Neon_Devil_Horns"
    case PingPong = "Ping_Pong"
    case PixelHearts = "Pixel_Hearts"
    case RayBan = "ray-ban-wayfarer"
    case Snail = "Snail"
    case SplitViewLook = "Split_View_Look"
    case Stallone = "Stallone"
    case VendettaMask = "Vendetta_Mask"
    case VikingHelmet = "viking_helmet"
    
    var path: String? {
        return Bundle.main.path(forResource: self.rawValue, ofType: "deepar")
    }
    
    var name: String {
        switch self {
        case .EmotionMeter:
            return "Meter"
        case .EmotionsExaggerator:
            return "Emotions"
        case .FireEffect:
            return "Fire"
        case .FlowerFace:
            return "Flowers"
        case .GalaxyBackground:
            return "Galaxy"
        case .Hope:
            return "Hope"
        case .MakeupLook:
            return "Makeup"
        case .NeonDevilHorns:
            return "Horns"
        case .PingPong:
            return "PingPong"
        case .PixelHearts:
            return "Pixel Hearts"
        case .RayBan:
            return "Ray Ban"
        case .Snail:
            return "Snail"
        case .SplitViewLook:
            return "Split View"
        case .Stallone:
            return "Stallone"
        case .VendettaMask:
            return "Vendetta"
        case .VikingHelmet:
            return "Viking"
            
        }
    }
}
