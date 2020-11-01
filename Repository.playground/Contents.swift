import UIKit

class MusicRepository {
    var path: String
    init(withPath path:String){
        self.path = path
    }
    // READ a single object
    func fetch(withId id: Int, withCompletion completion: @escaping (Music?) -> Void) {
        let URLstring = path + "music/id/\(id)"
        if let url = URL.init(string: URLstring){
            let task = URLSession.shared.dataTask(with: url, completionHandler:
            {(data, response, error) in
                if let user = try? JSONDecoder().decode(Music.self, from: data!){
                    completion (user)
                }
            })
            
            task.resume()
        }
    }
    
    //TODO: Build and test comparable methods for the other CRUD items
    
    func create( a:Music , withCompletion completion: @escaping (Music?) -> Void) {
        let URLstring = path + "music/id/\(a.id!)"
        var request = URLRequest.init(url: URL.init(string: URLstring)!)
       
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(a)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, _ in
           
            if let music = try? JSONDecoder().decode(Music.self, from: data!){
                completion (music)
            }
        }
        
        task.resume()
        
    }
    
    func update( withId id:Int, a:Music) {
    
        let URLstring = path + "music/id/\(a.id!)"
        var request = URLRequest.init(url: URL.init(string: URLstring)!)
       
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(a)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, _ in
            print (String.init(data: data!, encoding: .ascii) ?? "no data")
            
        }
        
        task.resume()
        
}
    
    func delete( withId id:Int ) {
        
        let URLstring = path + "music/id/\(id)"
        var request = URLRequest.init(url: URL.init(string: URLstring)!)
       
        request.httpMethod = "DELETE"
                
        let task = URLSession.shared.dataTask(with: request) {data, response, _ in
            print (String.init(data: data!, encoding: .ascii) ?? "no data")
            
        }
        
        task.resume()
        
    }
    
}

class Music: Codable {
    var id: String?
    var music_url: String?
    var name: String?
    var description: String?

}

//Create a User Repository for the API at http://216.186.69.45/services/device/users/
let musicRepo = MusicRepository(withPath: "https://www.orangevalleycaa.org/api/music")
//Fetch a single User
musicRepo.fetch(withId: 43, withCompletion: {(music) in
        print(music!.id ?? "no music")
})

/**
 * TODO: // Refactor the code using Generics and protocols so that you can re-use it as shown below
 *
 //Create a User Repository for the API at http://216.186.69.45/services/device/users/
 let userRepo = Repository<User>(withPath: "http://216.186.69.45/services/device/users/")
 
 //Fetch a single User
 userRepo.fetch(withId: 43, withCompletion: {(user) in
    print(user!.FirstName ?? "no user")
 })
 
 // Another type of object
 class Match: Codable {
 var name: String?
 var password: String?
 var countTIme: String?
 var seekTime: String?
 var status: String?
 }
 //Create a Match Repository for a different API at http://216.186.69.45/services/hidenseek/matches/
 let matchRepo = Repository<Match>(withPath: "http://216.186.69.45/services/hidenseek/matches/")
 
 //Fetch a single User
 matchRepo.fetch(withId: 1185, withCompletion: {(match) in
    print(match!.status ?? "no match")
 })
*/
