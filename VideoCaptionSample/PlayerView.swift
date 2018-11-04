//
//  PlayerView.swift
//  VideoCaptionSample
//
//  Created by Matsuoka Yoshiteru on 2018/11/05.
//  Copyright © 2018 culumn. All rights reserved.
//

import UIKit.UIView
import AVFoundation.AVPlayerLayer

final class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
