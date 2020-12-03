//
//  AnimeProvider.swift
//  MyAnimeList
//
//  Created by Rajkumar Gurunathan on 04/12/20.
//  Copyright © 2020 Rajkumar Gurunathan. All rights reserved.
//

import CoreData
import UIKit

class AnimeProvider {

    private var animeListVM: AnimeListViewModel!
    var animes = [Result]()

    /**
     Jikan (時間) is an open-source PHP & REST API for the “most active online anime + manga community and database” —
     */

    let animeFeed = URL(string: "https://api.jikan.moe/v3/search/anime?q=Naruto")!

    /**
     Fetches the anime feed from the remote server
     */
    func getAnimesFromServer(completion: @escaping ([Anime]?) -> Void) {

        URLSession.shared.dataTask(with: animeFeed) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let animeList = try? JSONDecoder().decode(AnimeList.self, from: data)
                if let animeList = animeList {
                    completion(animeList.results)
                }
            }
        }.resume()
    }

    /**
     Fetching from Coredata if there is no internet connection
     */
    func fetchAnimesFromCoreData() -> [Result] {

        let fetchRequest: NSFetchRequest<Result> = Result.fetchRequest()

        do {
            animes = try PersistenceService.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return animes
    }

    func save(animeList: AnimeListViewModel) {

        for anime in animeList.animes {
            let result = Result(context: PersistenceService.context)
            result.title = anime.title
            result.image_url = anime.image_url
            result.episodes = Int64(anime.episodes)
            result.score = anime.score
            result.synopsis = anime.synopsis

            let url = URL(string: anime.image_url)
            let data = try? Data(contentsOf: url!)
            result.image = UIImage(data: data!)?.jpegData(compressionQuality: 1.0)

            PersistenceService.saveContext()
        }
    }

    /**
     This method checks if data already saved or not and returns boolen based on the result
     */
    func saveAnimeInfo() -> Bool {

        let fetchRequest: NSFetchRequest<Result> = Result.fetchRequest()
        var results = [Result]()

        do {

            results = try PersistenceService.context.fetch(fetchRequest)

        } catch let error as NSError {

            print("Could not fetch. \(error), \(error.userInfo)")

        }
        return results.count > 0
    }

}
