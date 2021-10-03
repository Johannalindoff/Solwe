//
//  DataFactory.swift
//  Nasa
//
//  Created by Bredvid on 2021-10-03.
//

import Foundation

// A struct of weather data.
struct WeatherData: Identifiable {
    var year: String = ""
    var month: String = ""
    var day: String = ""
    var energy: String = ""
    var id = UUID()
    
    init(raw: [String]) {
        year = raw[0]
        month = raw[1]
        day = raw[2]
        energy = raw[3]
    }
}

// This function "loadCSV" gets an URL and initialize an array of struct
// elements corresponding to the data in the API.
//
// INPUT: URL in terms of a String
// OUTPUT: An array of wheather data
func loadCSV(from urlName: String) -> [WeatherData] {
    
    // The array that has to be filled and returned
    var urlToStruct = [WeatherData]()
    
    // Check if the URL is valid
    let url = URL(string: urlName)!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            print("successed")
        } else if let error = error {
            print("HTTP Request Failed \(error)")
        }
    }
    
    task.resume()
    
    // Save the data from url to a new string
    var dataString = ""
    do {
        dataString = try String(contentsOf: url)
    } catch {
        print(error)
    }

    // Split the string into an array of "rows" of data
    var rows = dataString.components(separatedBy: "\n")

    // Remove header rows, in this case 10, should be detected automatically
    // in a real app implementation
    rows.removeFirst(10)
    // Remove the last row, it is empty
    rows.removeLast()

    // Loop each row and split into columns
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        
        // Make a struct element of the data and save it in the array
        let weatherStruct = WeatherData.init(raw: csvColumns)
        urlToStruct.append(weatherStruct)
    }
    
    return urlToStruct
}

// This function "stringToDouble" converts a string to a
// double if possible
//
// INPUT: a string
// OUTPUT: a double
func stringToDouble(from stringValue: String) -> Double {
    
    if let doubleValue = Double(stringValue) {
        print("Float value = \(doubleValue)")
        return doubleValue
    } else {
        print("String does not contain Float")
        return 0
    }
}

