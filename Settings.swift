//
//  Settings.swift
//  Simon
//
//  Created by Josh Jaslow on 1/3/17.
//  Copyright © 2017 Jaslow Enterprises. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func changedSpeed(newSpeed: Double)
}

class Settings: UIViewController {
    weak var delegate: DataEnteredDelegate? = nil
    
    var speed: Double = 0.7
    var receivedSpeed: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speed = receivedSpeed
        speedLabel.text = "Speed = \(speed)"
        
        updateSegmentControl()
        updateStepper()
    }
    //MARK: - Outlets
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var segmentSpeed: UISegmentedControl!
    @IBOutlet weak var stepSpeed: UIStepper!
    
    //MARK: - Actions
    @IBAction func segmentSpeed(_ sender: UISegmentedControl) {
        
        switch segmentSpeed.selectedSegmentIndex {
        case 0:
            speed = 0.5
        case 1:
            speed = 0.6
        case 2:
            speed = 0.7
        default:
            break
        }
        speedLabel.text = "Speed = \(speed)"
        updateStepper()
    }
    
    @IBAction func stepSpeed(_ sender: UIStepper) {
        switch sender.value {
        case 2:
            speed = 0.7
        case 1:
            speed = 0.6
        case 0:
            speed = 0.5
        default:
            break
        }
        speedLabel.text = "Speed = \(speed)"
        updateSegmentControl()
    }
    
    func updateSegmentControl() {
        switch speed {
        case 0.7:
            segmentSpeed.selectedSegmentIndex = 2
        case 0.6:
            segmentSpeed.selectedSegmentIndex = 1
        case 0.5:
            segmentSpeed.selectedSegmentIndex = 0
        default:
            break
        }
    }
    
    func updateStepper() {
        switch speed {
        case 0.7:
            stepSpeed.value = 2
        case 0.6:
            stepSpeed.value = 1
        case 0.5:
            stepSpeed.value = 0
        default:
            break
        }
    }
    
    
    @IBAction func dismissPopover(_ sender: UIBarButtonItem) {
        delegate?.changedSpeed(newSpeed: speed)
        print("Speed is being changed")
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
}
