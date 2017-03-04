//
//  ViewController2.swift
//  RecipesProj
//
//  Created by MacBook on 04.03.17.
//  Copyright © 2017 mac os 109. All rights reserved.
//
 //https://developer.edamam.com
//https://api.edamam.com/search?q=burger&app_id=41af40ab&app_key=8fb9658a3c5bf0ba3b8a444e024a6647&from=0&to=20

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var recipes: [Recipes]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchRecipe()
    }

    func fetchRecipe(){
        let urlRequest = URLRequest(url: URL(string: "https://api.edamam.com/search?q=burger&app_id=41af40ab&app_key=8fb9658a3c5bf0ba3b8a444e024a6647&from=0&to=20")!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, responce, error) in
            
            if error != nil{
                print(error)
                return
            }
            self.recipes = [Recipes]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as!  [String:AnyObject]
                
                if let recipesFromJson = json["hits"] as? [[String : AnyObject]]{
                    for recipeFromJson in recipesFromJson{
                        let recipes = Recipes()
                        if let label = recipeFromJson["label"] as? String, let url = recipeFromJson["url"] as? String, let imageUrl = recipeFromJson["image"] as? String {
                            
                            recipes.label = label
                            recipes.imageUrl = imageUrl
                            recipes.url = url
                            
                        }
                    }
                }
                
            } catch let error {
                print(error)
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
   
}
