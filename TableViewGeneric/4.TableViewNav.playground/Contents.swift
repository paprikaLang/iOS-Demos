//: Playground - noun: a place where people can play
import PlaygroundSupport
import UIKit

struct Episode {
    let title: String
}

struct Season {
    let number: String
    let title: String
}

final class ItemViewController<Item,Cell: UITableViewCell>: UITableViewController {
    
    var items: [Item] = []
    let reuseIdentifier = "Cell"
    let configure: (Cell,Item) -> ()
    var didSelect: (Item)-> () = { _ in }
    init(items:[Item], configure: @escaping (Cell, Item) -> ()){
        self.configure = configure
        
        super.init(style: .plain)
        self.items = items
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        tableView.register(Cell.self,forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell,item)
        return cell
    }
}

let sampleEpisodes = [Episode(title:"First Episode"),Episode(title: "Second Episode"),Episode(title:"Third Episode")]
let sampleSeasons = [Season(number:"1", title: "First Season"),Season(number:"2",title:"Second Season")]

final class SeasonCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let itemVC = ItemViewController(items:sampleSeasons, configure:{(cell:SeasonCell, item) in
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.number
})
itemVC.title = "Seasons"

let nc = UINavigationController(rootViewController: itemVC)

itemVC.didSelect = { season in
    let episodesVC = ItemViewController(items: sampleEpisodes, configure: { cell, episode in
        cell.textLabel?.text = episode.title
    })
    episodesVC.title = season.title
    nc.pushViewController(episodesVC, animated: true)
    
}
nc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
PlaygroundPage.current.liveView = nc.view

