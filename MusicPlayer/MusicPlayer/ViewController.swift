//
//  ViewController.swift
//  MusicPlayer2
//
//  Created by Shapes on 13/11/2015.
//  Copyright © 2015 Shapes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var trackPicker: UIPickerView!
    
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    var error = "Error"
    var artist: String?
    var track: String?
    
    var artistDictionary = [String: String]()
    var artistArray: [[String]] = [[String]]()
    var trackDictionary = [String: String]()
    var trackArray: [[String]] = [[String]]()
    
    @IBAction func playOrPauseMusic(sender: AnyObject) {
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
        } else {
            audioPlayer.play()
            isPlaying = true
        }
    }
    
    @IBAction func stopMusic(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        isPlaying = false
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.trackPicker.delegate = self
        self.trackPicker.dataSource = self
        
        artistDictionary = ["ACDC": "ACDC", "BMTH": "BMTH", "Caribou":"Caribou", "David Guetta":"David Guetta", "Disclosure":"Disclosure", "Jon Hopkins":"Jon Hopkins", "DJ Krush":"DJ Krush","DJ Shadow":"DJ Shadow", "Tupac":"Tupac", "Notorious":"Notorious"]
        trackDictionary = ["ACDC": "ACDC", "BMTH": "BMTH", "Caribou":"Caribou", "David Guetta":"David Guetta", "Disclosure":"Disclosure", "Jon Hopkins":"Jon Hopkins", "DJ Krush":"DJ Krush","DJ Shadow":"DJ Shadow", "Tupac":"Tupac", "Notorious":"Notorious"]
        
        let artistSortedKeys = Array(artistDictionary.keys).sort(<)
        artistArray = [artistSortedKeys,artistSortedKeys]
        
        let trackSortedKeys = Array(trackDictionary.keys).sort(<)
        trackArray = [trackSortedKeys,trackSortedKeys]
        
        for (var row=0;row<artistArray[0].count;row++){
            if (artistArray[0][row] == "ACDC"){
                trackPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
        for (var row=0;row<artistArray[1].count;row++){
            if (artistArray[1][row] == "ACDC"){
                trackPicker.selectRow(row, inComponent: 1, animated: true)
            }
        }
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return artistDictionary.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return artistArray[component][row]
    }
    
    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(component == 0){
            track = trackDictionary[trackArray[component][row]]
            artist = artistDictionary[artistArray[component][row]]
        }
        else if (component == 1){
            track = trackDictionary[trackArray[component][row]]
        }
        
        print(track)
        
        let path = NSBundle.mainBundle().URLForResource(track, withExtension: "mp3")
        try! audioPlayer = AVAudioPlayer(contentsOfURL: path!, fileTypeHint: error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}





