import Foundation

struct ApiConstants {
    
    // MARK: - Local server path
    static let serverPath = "http://localhost:3000/"
    
    // MARK: - Users
    static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
    
    // MARK: - Posts
    static let postsPath = serverPath + "posts"
    static let postsURL = URL(string: postsPath)
    
    // MARK: - ToDo
    static let todosPath = serverPath + "todos"
    static let todosURL = URL(string: todosPath)
    
    // MARK: - Albums
    static let albumsPath = serverPath + "albums"
    static let albumsURL = URL(string: albumsPath)
    
    // MARK: - Photos
    static let photosPath = serverPath + "photos"
    static let photosURL = URL(string: photosPath)
    
    // MARK: - Comments
    static let commentsPath = serverPath + "comments"
    static let commentsURL = URL(string: commentsPath)
}


