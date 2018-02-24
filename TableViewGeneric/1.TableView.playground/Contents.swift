//: Playground - noun: a place where people can play
import PlaygroundSupport
import UIKit
import Foundation
struct Episode {
    let title: String
}

final class EpisodesViewController: UITableViewController {
    var episodes: [Episode] = []
    let reuseIdentifier = "Cell"
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: reuseIdentifier)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = episodes[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
}

let sampleEpisodes = [Episode(title:"First Episode"),Episode(title: "Second Episode"),Episode(title:"Third Episode")]

let episodeVC = EpisodesViewController()
episodeVC.episodes = sampleEpisodes
episodeVC.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
PlaygroundPage.current.liveView = episodeVC.view

