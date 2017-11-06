//
//  SkillVC.swift
//  Swoosh
//
//  Created by Melanie Ren on 11/1/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class SkillVC: UIViewController {

    var player: Player!
    @IBOutlet weak var finishBtn: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(player.desiredLeague)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBegTapped(_ sender: Any) {
        selectSkillLevel(skillLevel: "beg")
    }
    
    @IBAction func onBallerTapped(_ sender: Any) {
        selectSkillLevel(skillLevel: "baller")
    }
    
    func selectSkillLevel(skillLevel: String) {
        player.selectedSkillLevel = skillLevel
        finishBtn.isEnabled = true
        finishBtn.isHidden = false
        print(player.selectedSkillLevel)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
