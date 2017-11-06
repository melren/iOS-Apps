//
//  LeagueVC.swift
//  Swoosh
//
//  Created by Melanie Ren on 11/1/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {

    //declare implicitly unwrapped optional
    //code that won't run without the player
    var player: Player!
    
    //weak means this is linked to the reference in the board
    @IBOutlet weak var nextBtn: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        player = Player()
    }

    @IBAction func onNextTapped(_ sender: Any) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }

    @IBAction func onMensTapped(_ sender: Any) {
        selectLeague(leagueType: "mens")
    }
    
    @IBAction func onWomensTapped(_ sender: Any) {
        selectLeague(leagueType: "womens")
    }
    
    @IBAction func onCoedTapped(_ sender: Any) {
        selectLeague(leagueType: "coed")
    }

    //avoid logic in the IBAction
    func selectLeague(leagueType: String) {
        player.desiredLeague = leagueType
        nextBtn.isEnabled = true
        nextBtn.isHidden = false
    }
    
}
