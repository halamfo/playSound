//
//  ViewController.swift
//  Play Sound
//
//  Created by Dân Tơi on 6/22/16.
//  Copyright © 2016 Dân Tơi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audio =  AVAudioPlayer()
    var status = ""
    
    @IBOutlet weak var sld_duration: UISlider!
    @IBOutlet weak var lbl_timeremain: UILabel!
    @IBOutlet weak var lbl_currenttime: UILabel!
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
    
    @IBAction func actionsld_duration(sender: UISlider) {
        audio.stop()
        audio.currentTime = NSTimeInterval(sld_duration.value)
        audio.prepareToPlay()
        btn_play.setImage(UIImage(named: "pause.png"), forState: .Normal)
        audio.play()
        status = "play"
    }
    func updateTimeleft(){
        lbl_currenttime.text = String(format: "%02.0f", (audio.currentTime/60) % 60) + ":" + String(format: "%02.0f", audio.currentTime % 60)
        lbl_timeremain.text = String(format: "%02.0f",((audio.duration - audio.currentTime)/60)%60) + ":" + String(format: "%02.0f",((audio.duration - audio.currentTime)%60))
        sld_duration.value  = Float(audio.currentTime)
    }
    @IBAction func `switch`(sender: UISwitch) {
        if sender.on {
            audio.numberOfLoops = 1
        }
        else{
            audio.numberOfLoops = 0
        }
    }
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if audio.numberOfLoops == 0{
            audio.stop()
            btn_play.setImage(UIImage(named: "play.png"), forState: .Normal)
            status = "pause"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: (NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!)))
        audio.prepareToPlay()
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTimeleft), userInfo: nil, repeats: true)
        audio.delegate = self
        audio.numberOfLoops = 1
        sld_duration.maximumValue = Float(audio.duration)
        sld_duration.setThumbImage(UIImage(named: "duration.png"), forState: .Normal)

    }
}

