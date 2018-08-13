//
//  Logic
//  Simon
//
//  Created by Josh Jaslow on 12/15/16.
//  Copyright © 2016 Jaslow Enterprises. All rights reserved.
//

import UIKit

class Logic: UIViewController, DataEnteredDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        changeButtonState(state: false)
        funDisplay()
    }
    
    //MARK: - Outlets
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var startOver: UIButton!
    @IBOutlet weak var settings: UIBarButtonItem!
    @IBOutlet weak var hint: UIButton!
    
    //MARK: - Properties
    var lightUpTime: Double = 0.2
    var score: Int = 0
    var timeBetween: Double = 0.7
    var playPressed: Bool = false
    
    //MARK: - Data Storage
    var userInput: [Int] = []
    var cpuInput: [Int] = []
    
    //MARK: - Buttons
    @IBAction func play(_ sender: UIButton) {
        changeButtonState(state: true)
        
        play.isEnabled = false
        
        playPressed = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.cpuTurn()
        }
    }
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        self.title = ""
    }
    
    @IBAction func hint(_ sender: UIButton) {
        userInput = []
        runThroughCPUArr()
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        score = 0
        //timeBetween = 0.5
        funDisplay()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            self.title = "Play again?"
        }
        userInput = []
        cpuInput = []
        changeButtonState(state: false)
        play.isEnabled = true
        playPressed = false
    }
    
    @IBAction func greenButtonTapped(_ sender: UIButton) {
        tapButton(button: greenButton, lightImage: UIImage(named: "greenCircle")!)
        checkArr(buttonNum: 1)
    }
    @IBAction func redButtonTapped(_ sender: UIButton) {
        tapButton(button: redButton, lightImage: UIImage(named: "redCircle")!)
        checkArr(buttonNum: 2)
    }
    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        tapButton(button: yellowButton, lightImage: UIImage(named: "yellowCircle")!)
        checkArr(buttonNum: 3)
    }
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        tapButton(button: blueButton, lightImage: UIImage(named: "blueCircle")!)
        checkArr(buttonNum: 4)
    }
    
    @IBAction func testNote(_ sender: UIButton) {
        //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {}
    }
    
    //MARK: - Functions
    func checkArr (buttonNum: Int) {
        userInput.append(buttonNum)
        
        if userInput[userInput.count - 1] != cpuInput[userInput.count-1] {
            self.title = "YOU LOSE!"
            score = 0
            //timeBetween = 0.7
            funDisplay()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self.title = "Play again?"
            }
            userInput = []
            cpuInput = []
            changeButtonState(state: false)
            play.isEnabled = true
            playPressed = false
        }
        
        else if cpuInput.elementsEqual(userInput) {
            score += 20
            self.title = "You have \(score) points"
            cpuTurn()
            userInput = []
        }
        
    }
    
    func cpuTurn() {
        changeButtonState(state: false)
        
        cpuInput.append(randomInt(min: 1, max: 4))
        
        runThroughCPUArr()
    }
    
    func runThroughCPUArr() {
        var timeBeforeRunThrough: Double = 1.0
        
        for i in cpuInput {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeBeforeRunThrough) {
                
                switch i {
                    
                case 1:
                    self.tapButton(button: self.greenButton, lightImage: UIImage(named: "greenCircle")!)
                
                case 2:
                    self.tapButton(button: self.redButton, lightImage: UIImage(named: "redCircle")!)
                
                case 3:
                    self.tapButton(button: self.yellowButton, lightImage: UIImage(named: "yellowCircle")!)
                
                case 4:
                    self.tapButton(button: self.blueButton, lightImage: UIImage(named: "blueCircle")!)
                
                default:
                    print("ERROR")
                }
            }
            timeBeforeRunThrough += timeBetween
        }
        
        changeButtonState(state: true)
    }
    
    func tapButton(button: UIButton, lightImage: UIImage) {
        let originalImage = button.image(for: .normal)
        
        button.setImage(lightImage, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + lightUpTime) {
            // here code perfomed after delay
            button.setImage(originalImage, for: .normal)
        }
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func changeButtonState(state: Bool) {
        greenButton.isEnabled = state
        redButton.isEnabled = state
        yellowButton.isEnabled = state
        blueButton.isEnabled = state
        startOver.isEnabled = state
        hint.isEnabled = state
        settings.isEnabled = !state
        play.isEnabled = !state
    }
    
    //MARK: - Fun Displays
    func funDisplay() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.tapButton(button: self.redButton, lightImage: UIImage(named: "redCircle")!)
            if !self.playPressed{
                self.funDisplay2()
            }
        }
    }
    
    func funDisplay2(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.tapButton(button: self.greenButton, lightImage: UIImage(named: "greenCircle")!)
            if !self.playPressed{
                self.funDisplay3()
            }
        }
    }
    
    func funDisplay3(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.tapButton(button: self.yellowButton, lightImage: UIImage(named: "yellowCircle")!)
            if !self.playPressed{
                self.funDisplay4()
            }
        }
    }
    
    func funDisplay4(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.tapButton(button: self.blueButton, lightImage: UIImage(named: "blueCircle")!)
            if !self.playPressed{
                self.funDisplay()
            }
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? UINavigationController
        let settingsVC = navVC?.viewControllers.first as! Settings
        settingsVC.delegate = self
        
        settingsVC.receivedSpeed = timeBetween
    }
    
    func changedSpeed(newSpeed: Double) {
        timeBetween = newSpeed
        print("Speed changed to \(timeBetween)")
    }
}
extension UIColor {
    //color: UIColor(netHex: 0xB9F086)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

