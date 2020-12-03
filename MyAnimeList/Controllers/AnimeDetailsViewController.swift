//
//  AnimeDetailsTableViewController.swift
//  MyAnimeList
//
//  Created by Rajkumar Gurunathan on 02/12/20.
//  Copyright © 2020 Rajkumar Gurunathan. All rights reserved.
//

import UIKit

class AnimeDetailsViewController: UIViewController {

    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var animePoster: UIImageView!
    @IBOutlet weak var animeSynopsys: UILabel!
    @IBOutlet weak var animeTypeLbl: UILabel!
    @IBOutlet weak var animeScoreLbl: UILabel!
    @IBOutlet weak var animeEpisodesLbl: UILabel!
    var animeListVM: AnimeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(animeListVM.title) Details"
        loadDetails()

    }

    func loadDetails() {
        animeTitleLabel.text = animeListVM.title
        animeSynopsys.text = animeListVM.synopsis
        animeTypeLbl.text = animeListVM.type
        animeScoreLbl.text = animeListVM.score
        animeEpisodesLbl.text = animeListVM.episodes
        if let url = URL(string: animeListVM.imageUrl) {
            if let data = try? Data(contentsOf: url) {
                animePoster.image = UIImage(data: data)
            }
        }

    }

}
