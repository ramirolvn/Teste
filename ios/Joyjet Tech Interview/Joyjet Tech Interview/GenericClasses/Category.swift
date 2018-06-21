class Category {
    
    var name: String
    var items: [CategoryItems]
    
    init(name: String, items: [CategoryItems]) {
        self.name = name
        self.items = items
    }
}
