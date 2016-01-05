//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Jens Van Steen on 02/01/16.
//  Copyright © 2016 Jens Van Steen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum operation: String {
        
        case multiply = "*"
        case add = "+"
        case subtract = "-"
        case empty = "Empty"
        case divide = "/"
    }
    
    //Outlets
    @IBOutlet weak var outputlabel: UILabel!
    
    //Variables
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: operation = operation.empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
       let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

 //Actions
    
    @IBAction func onClearButtonPressed(sender: UIButton) {
        playSound()
        
        outputlabel.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = operation.empty
        
    }
    
    @IBAction func numberpressed(btn: UIButton!) {
        playSound()
        
        
        runningNumber += "\(btn.tag)"
        outputlabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation.divide)
    }
  
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation.multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation.subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation.add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    //Functions
    
    func processOperation(op: operation) {
        playSound()
        
        // als current operation NIET gelijk is aan empty
        if currentOperation != operation.empty {
            //math
            
            // a user selcted a operator, but then selected a other operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == operation.multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                 else if currentOperation == operation.add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == operation.subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == operation.divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputlabel.text = result
            }
           
            currentOperation = op
                
            
        } else {
            //first time a operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
            
                    }
        btnSound.play()
    }
}

