//
//  ViewController.swift
//  MusicPlayer2
//
//  Created by Shapes on 13/11/2015.
//  Copyright © 2015 Shapes. All rights reserved.
//

import UIKit
import AVFoundation

class PopulationOfArrays {
    
    
    func artistValues() -> [String] {
        return ["ACDC", "BMTH", "Krush", "Tupac", "Notorious", "Shadow"]
    }
    
    func trackValues(done: String) -> [String] {
        if done == "ACDC" {
            return ["Thunderstruck", "Big Gun", "Moneytalks", "Back In Black"]
        }
        if done == "BMTH" {
            return ["Happy Song", "Throne", "True Friends", "Oh No"]
        }
        if done == "Krush" {
            return ["Song 1", "Zen Approach", "Danger Of Love", "Candle Chant"]
        }
        if done == "Tupac" {
            return ["Hit Em Up", "Changes", "All About You", "Dear Mama"]
        }
        if done == "Notorious" {
            return ["Hypnotize", "Notorious Thugs", "Sky's The Limit", "You're Nobody"]
        }
        else {
            return["Midnight", "Bloodstain", "Lonely Soul", "Unkle"]
        }
    }
}




class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var trackPicker: UIPickerView!
    @IBOutlet weak var artistPicker: UIPickerView!
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    var error = "Error"
    var artist: String?
    var track: String?
    
    var artistDictionary = [String: String]()
    var artistArray: [[String]] = [[String]]()
    var trackDictionary = [String: String]()
    var trackArray: [[String]] = [[String]]()
    var picker1Options:[String] = []
    var picker2Options:[String] = []

    
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
        
        let artistGeneration = PopulationOfArrays();
        
        picker1Options = artistGeneration.artistValues()
        let firstValue = picker1Options[0]
        picker2Options = artistGeneration.trackValues(firstValue)
        
        artistDictionary = ["ACDC": "ACDC", "BMTH": "BMTH", "DJ Krush":"DJ Krush","DJ Shadow":"DJ Shadow", "Tupac":"Tupac", "Notorious":"Notorious"]
        trackDictionary = ["ACDC": "ACDC", "BMTH": "BMTH", "DJ Krush":"DJ Krush","DJ Shadow":"DJ Shadow", "Tupac":"Tupac", "Notorious":"Notorious"]

        let artistSortedKeys = Array(artistDictionary.keys).sort(<)
        artistArray = [artistSortedKeys,artistSortedKeys]
        
        let trackSortedKeys = Array(trackDictionary.keys).sort(<)
        trackArray = [trackSortedKeys,trackSortedKeys]
        
        for (var row=0;row<artistArray[0].count;row++){
            if (artistArray[0][row] == "ACDC"){
                trackPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (component == 0) {
            return picker1Options.count
        } else {
            return picker2Options.count
        }

    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            //print( "\(picker1Options[row])")
            return "\(picker1Options[row])"
            
        }
        else {
            //print( "\(picker2Options[row])")
            return "\(picker2Options[row])"
        }
    }
    
    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            let artistGeneration = PopulationOfArrays();
            let currentValue = picker1Options[row]
            picker2Options = artistGeneration.trackValues(currentValue)
            pickerView.reloadAllComponents()
        }

        
        else if(component == 1){
            
            track = "\(picker2Options[row])"
            print(track)

                }
        
        
        let path = NSBundle.mainBundle().URLForResource(track, withExtension: "mp3")
        try! audioPlayer = AVAudioPlayer(contentsOfURL: path!, fileTypeHint: error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}