//
//  DatabaseViewModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/12/23.
//
//
import Foundation
class apiCall{
    func getKingsPointTides(completion:@escaping ([TidalData]) -> ()) {
        //we first make a guard let statement on our url variable. This is to check to make sure we have a valid URL otherwise the function will stop there and not execute the rest of the code.
        guard let url = URL(string:"https://tide-gps-data-app-default-rtdb.firebaseio.com/kingspoint-921-924-predictions.json") else {return}
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            let tides = try! JSONDecoder().decode([TidalData].self, from: data!)
            //            print(tides)
            
            // Next we use URLSession to make our call to get the data from the URL. Inside of our URLSession closure we create a new variable called comments and we assign the decoded JSON to our variable. Then we use DispatchQueue to make sure we are running this API call on the main thread and not a background thread of our app. On completion of retrieving our data we then assigns the data to our comments variable. Lastly we can't forget the .resume() function at the end of your URLSession curly brace. If you forget this the function will never run the API call to the URL.
            
            DispatchQueue.main.async {
                completion(tides)
            }
        }
        .resume()
        
        func filterTides(){
        
        }
    }
}
    
    
