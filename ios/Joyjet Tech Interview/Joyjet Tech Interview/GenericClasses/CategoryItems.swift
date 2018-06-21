class CategoryItems {
    
    var title: String
    var description: String
    var photosGaleryUrl: [String]
    var categoryName: String
    
    init(title: String, description: String, photosGaleryUrl: [String], categoryName: String) {
        self.title = title
        self.description = description
        self.photosGaleryUrl = photosGaleryUrl
        self.categoryName = categoryName
    }
}
