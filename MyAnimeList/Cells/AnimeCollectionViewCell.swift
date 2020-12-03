//
//  AnimeCollectionViewCell.swift
//  MyAnimeList
//
//  Created by Rajkumar Gurunathan on 01/12/20.
//  Copyright © 2020 Rajkumar Gurunathan. All rights reserved.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animeImage: UIImageView!

    /**
     Configures the cell with a animeVM instance.
     */
    func configure(with animeVM: AnimeViewModel) {
        titleLabel.text = animeVM.title

        let queue = DispatchQueue(label: "queuename", attributes: .concurrent)

        queue.async { () -> Void in
            let url = URL(string: animeVM.imageUrl)
            let data = try? Data(contentsOf: url!)

            DispatchQueue.main.async {
                self.animeImage.image = UIImage(data: data!)
            }
        }
    }

}
