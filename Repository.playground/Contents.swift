import UIKit

class UserRepository {
    var path: String
    init(withPath path:String){
        self.path = path
    }
    
    func fetch(withId id: Int, withCompletion completion: @escaping (User?) -> Void) {
        let URLstring = path + "\(id)"
        if let url = URL.init(string: URLstring){
            let task = URLSession.shared.dataTask(with: url, completionHandler:
            {(data, response, error) in
                if let user = try? JSONDecoder().decode(User.self, from: data!){
                    completion (user)
                }
            })
            task.resume()
        }
    }
}

class User: Codable {
    var UserID: String?
    var FirstName: String?
    var LastName: String?
    var PhoneNumber: String?
    var SID: String?
}

//Create a User Repository for the API at http://216.186.69.45/services/device/users/
let userRepo = UserRepository(withPath: "http://216.186.69.45/services/device/users/")

//Fetch a single User
userRepo.fetch(withId: 43, withCompletion: {(user) in
        print(user!.FirstName ?? "no user")
})


