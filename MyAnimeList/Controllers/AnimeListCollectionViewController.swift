//
//  AnimeListCollectionViewController.swift
//  MyAnimeList
//
//  Created by Rajkumar Gurunathan on 01/12/20.
//  Copyright © 2020 Rajkumar Gurunathan. All rights reserved.
//

import UIKit
import CoreData
class AnimeListCollectionViewController: UIViewController {
    /**
     The AnimeProvider that fetches anime data, saves it to Core Data,
     and serves it to this collection view.
     */
    @IBOutlet weak var animeCollectionView: UICollectionView!

    private var animeListVM: AnimeListViewModel!

    var selectedAnimeDetails: AnimeViewModel!
    let provider = AnimeProvider()
    var animes = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()

        if Reachability.isConnectedToNetwork() {

            provider.getAnimesFromServer { animes in
                if let animes = animes {
                    self.animeListVM = AnimeListViewModel(animes: animes)

                    DispatchQueue.main.async {
                        if !self.provider.saveAnimeInfo() {
                            self.provider.save(animeList: self.animeListVM)
                        }
                        self.animeCollectionView.reloadData()
                    }
                }
            }
        } else {
            animes = provider.fetchAnimesFromCoreData()
        }
    }

    private func navBarSetup() {
        //To show title on left
        let titleTxt = "Anime List !"
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = titleTxt
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animedetails" {
            let animeDetailsViewController = segue.destination as! AnimeDetailsViewController
            animeDetailsViewController.animeListVM = self.selectedAnimeDetails
        }
    }

}
// MARK: - UICollectionViewDataSource
extension AnimeListCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if Reachability.isConnectedToNetwork() {
            if let animeList = self.animeListVM {
                return animeList.numberOfRowsInSection(section)
            } else {
                return 0
            }
        } else {
            return animes.count
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeTableViewCell", for: indexPath) as? AnimeCollectionViewCell else {
            fatalError("AnimeTableViewCell not found")
        }

        if Reachability.isConnectedToNetwork() {
            let animeVM = self.animeListVM.animeAtIndex(indexPath.row)

            cell.configure(with: animeVM)

        } else {
            //CoreData
            cell.titleLabel.text = animes[indexPath.row].title
            if let imageData = animes[indexPath.row].image {
                cell.animeImage.image = UIImage(data: imageData)
            }
        }

        return cell
    }

}
// MARK: - UICollectionViewDelegate
extension AnimeListCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork() {
            selectedAnimeDetails = self.animeListVM.animeAtIndex(indexPath.row)
            self.performSegue(withIdentifier: "animedetails", sender: nil)
        }
    }
}
