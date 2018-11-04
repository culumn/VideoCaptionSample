//
//  ViewController.swift
//  VideoCaptionSample
//
//  Created by Matsuoka Yoshiteru on 2018/11/05.
//  Copyright © 2018 culumn. All rights reserved.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {

    @IBOutlet weak var videoView: PlayerView!
    @IBOutlet weak var captionLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        // URLから AVPlayerItem, AVPlayer を生成
        let videoURLString = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
        guard let videoURL = URL(string: videoURLString) else { fatalError("Failed to create url") }
        let videoPlayerItem = AVPlayerItem(url: videoURL)
        let videoPlayer = AVPlayer(playerItem: videoPlayerItem)

        // AVPlayerItemLegibleOutput を生成する
        // デリゲート先をセットし、 `videoPlayerItem` に追加
        let legibleOutput = AVPlayerItemLegibleOutput(mediaSubtypesForNativeRepresentation: [])
        legibleOutput.setDelegate(self, queue: .main)
        legibleOutput.suppressesPlayerRendering = true
        videoPlayerItem.add(legibleOutput)

        // 動画を再生するビューを設定する
        let videoPlayerLayer = videoView.playerLayer
        videoPlayerLayer.videoGravity = .resize
        videoPlayerLayer.player = videoPlayer

        // ラベルをクリア
        captionLabel.text = ""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 動画を再生
        videoView.player?.play()
    }
}

// MARK: - AVPlayerItemLegibleOutputPushDelegate
extension ViewController: AVPlayerItemLegibleOutputPushDelegate {

    func legibleOutput(
        _ output: AVPlayerItemLegibleOutput,
        didOutputAttributedStrings strings: [NSAttributedString],
        nativeSampleBuffers nativeSamples: [Any],
        forItemTime itemTime: CMTime
        ) {
        // 字幕をラベルにセット
        captionLabel.attributedText = strings.first
    }
}
