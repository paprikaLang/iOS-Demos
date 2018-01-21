//: Playground - noun: a place where people can play
import PlaygroundSupport
import UIKit

struct Artist {
    var name: String
}
struct Album {
    var title: String
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

//dataSource
let artists: [Artist] = [
    Artist(name: "Prince"),
    Artist(name: "GreenDay")
]
let albums: [Album] = [
    Album(title: "Wake Me up"),
    Album(title: "Game over")
]

enum RecentItem {
    case artist(Artist)
    case album(Album)
}
let recentItems: [RecentItem] = [
    .artist(artists[0]),
    .artist(artists[1]),
    .album(albums[1])
]


let itemVC = ItemViewController(items:recentItems, configure:{(cell, item) in
    switch item {
    case .artist(let artist):
        cell.textLabel?.text = artist.name
    case .album(let album):
        cell.textLabel?.text = album.title
    }
    
    
})

let nc = UINavigationController(rootViewController: itemVC)

itemVC.didSelect = { album in
    let episodesVC = ItemViewController(items: recentItems, configure: { cell, item in
        switch item {
        case .artist(let artist):
            cell.textLabel?.text = artist.name
        case .album(let album):
            cell.textLabel?.text = album.title
        }
    })
    nc.pushViewController(episodesVC, animated: true)
    
}
nc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
PlaygroundPage.current.liveView = nc.view

