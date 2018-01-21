//: Playground - noun: a place where people can play
import PlaygroundSupport
import UIKit

struct Artist {
    var name: String
}
struct Album {
    var title: String
}

struct CellDescriptor{
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configure: (UITableViewCell) -> ()
    init<Cell: UITableViewCell>(reuseIdentifier:String,configure:@escaping (Cell) -> ()){
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}

final class ItemViewController<Item>: UITableViewController {
    
    var items: [Item] = []
    let cellDescriptor: (Item)-> CellDescriptor
    var didSelect: (Item)-> () = { _ in }
    var reuseIdentifiers: Set<String> = []
    init(items:[Item], cellDescriptor: @escaping (Item) -> CellDescriptor){
        
        self.cellDescriptor = cellDescriptor
        super.init(style: .plain)
        self.items = items
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)
        if !reuseIdentifiers.contains(descriptor.reuseIdentifier) {
            tableView.register(descriptor.cellClass, forCellReuseIdentifier: descriptor.reuseIdentifier)
            reuseIdentifiers.insert(descriptor.reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        
        descriptor.configure(cell)
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

final class ArtistCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
final class AlbumCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension Artist {
//    func configureCell(_ cell: ArtistCell) {
//        cell.textLabel?.text = name
//    }
//}

let itemVC = ItemViewController(items:recentItems, cellDescriptor:{ item in
    switch item {
    case .artist(let artist):
        return CellDescriptor(reuseIdentifier: "artist", configure: { (cell:ArtistCell) in
            cell.textLabel?.text = artist.name
        })
        
    case .album(let album):
        return CellDescriptor(reuseIdentifier: "album", configure: { (cell:AlbumCell) in
            cell.textLabel?.text = album.title
        })
    }
})

let nc = UINavigationController(rootViewController: itemVC)

itemVC.didSelect = { album in
    let episodesVC = ItemViewController(items: recentItems, cellDescriptor: { item in
        switch item {
        case .artist(let artist):
            return CellDescriptor(reuseIdentifier: "artist", configure: { (cell:ArtistCell) in
                cell.textLabel?.text = artist.name
            })
            
        case .album(let album):
            return CellDescriptor(reuseIdentifier: "album", configure: { (cell:AlbumCell) in
                cell.textLabel?.text = album.title
            })
        }
    })
    nc.pushViewController(episodesVC, animated: true)
    
}
nc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
PlaygroundPage.current.liveView = nc.view

