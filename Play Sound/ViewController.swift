//
//  ViewController.swift
//  Play Sound
//
//  Created by Dân Tơi on 6/22/16.
//  Copyright © 2016 Dân Tơi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audio =  AVAudioPlayer()
    var status = ""
    @IBOutlet weak var btn_play: UIButton!
    @IBAction func actionplay(sender: AnyObject) {
        if status == "play"{
            audio.pause()
            btn_play.setImage(UIImage(named: "play.png"), forState: .Normal)
            status = "pause"
        }
        else{
        btn_play.setImage(UIImage(named: "pause.png"), forState: .Normal)
        audio.play()
        status = "play"
        }
    }
    @IBOutlet weak var sldvolume: UISlider!
    @IBAction func sldvolume(sender: UISlider) {
        audio.volume = sender.value
        sldvolume.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        sldvolume.setThumbImage(UIImage(named: "thumbHightLight.png"), forState: .Highlighted)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: (NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!)))
        audio.prepareToPlay()
    }
}

