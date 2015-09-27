//
//  playSoundViewController.swift
//  Voice Recorder
//
//  Created by Ravindar on 25/09/15.
//  Copyright © 2015 tk. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var audioEngine: AVAudioEngine!

    var receivedAudio = RecordedAudio!()
    
    var audioFile = AVAudioFile!()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()

/*
        // Do any additional setup after loading the view.
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            let filePathUrl = NSURL.fileURLWithPath(filePath)
          
        }
        else{
            print("Error in loading mp3 file!")
        }*/
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        }
        catch{print("Eror")}
        audioPlayer.enableRate = true
        
        do{
            audioFile = try AVAudioFile(forReading: receivedAudio.filePathUrl)
        }
        catch { print("Error:")}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowly(sender: UIButton) {
        print("Workin")
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    @IBAction func playFastly(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    
    @IBAction func playChipmunk(sender: UIButton) {
       playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopAllAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
