//
//  DatabaseViewModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/12/23.
//
//
import Foundation

class apiCall{
    //do I have to add the if else statements for where I'm calling from first?
    func getKingsPointTides(completion:@escaping ([TidalData]) -> ()) {
        //we first make a guard let statement on our url variable. This is to check to make sure we have a valid URL otherwise the function will stop there and not execute the rest of the code.
        guard let url = URL(string:"https://tide-gps-data-app-default-rtdb.firebaseio.com/kingspoint-921-924-predictions.json") else {return}
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            
//            list<tidaldata> = data.map( it -> decode(it))
            
//            let tides: Array<Any> = data.map(try! JSONDecoder().decode([TidalData].self)
            let tides = try! JSONDecoder().decode([TidalData].self, from: data!)
                        print(tides)
            
//            var todaysTides: Array<Any>?
//            
//            for _ in tides {
//                todaysTides?.append
//            }
            //returns an instance of the class for EACH element of the JSON array ie:
//            Tidal_GPS_App.TidalData(id: DD223D1E-CF47-4EA4-93DD-A559967F793D, t: "2023-09-24 22:48", v: "17.337"), Tidal_GPS_App.TidalData(id: 1309EC72-D7EF-4227-B4AC-0E205F7D3809, t: "2023-09-24 22:54", v: "17.138"), Tidal_GPS_App.TidalData(id: C1B598A9-A1AA-4029-BE7B-70E9B8F7AE86, t: "2023-09-24 23:00", v: "16.938"), Tidal_GPS_App.TidalData(id: BF7E7D56-AEE1-46D1-87E3-C179ABFC237B, t: "2023-09-24 23:06", v: "16.739"),
            
//            var filteredTides = [[TidalData]]
//
//            tides.map{item in
//                if let time = item.t{
//                if(time != "2023-09-21 00:"){
//                    filteredTides.append(item)
//                }
//                }
//                return;
            
            // Next we use URLSession to make our call to get the data from the URL. Inside of our URLSession closure we create a new variable called comments and we assign the decoded JSON to our variable. Then we use DispatchQueue to make sure we are running this API call on the main thread and not a background thread of our app. On completion of retrieving our data we then assigns the data to our comments variable. Lastly we can't forget the .resume() function at the end of your URLSession curly brace. If you forget this the function will never run the API call to the URL.
            
            DispatchQueue.main.async {
                completion(tides)
            }
        }
        .resume()
    }
}
    
