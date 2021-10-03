//
//  HomeView.swift
//  Nasa
//
//  Created by Bredvid on 2021-10-03.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    
    // weatherDataUme gets the value of an array after calling the function loadCSV
    // in the DataFactory file with the input from an url. The data from this API-url
    // is very limited. The API shows data of solar radiance in Umeå, Sweden one week
    // in september 2020. In a real app, the data should be larger, and the user
    // should be able to choose location and what type of data that is interesting.
    var weatherDataUme = loadCSV(from: "https://power.larc.nasa.gov/api/temporal/daily/point?parameters=ALLSKY_SFC_SW_DWN&community=RE&longitude=20.3068&latitude=63.8207&start=20200920&end=20200926&format=CSV")
    
    // This is just some made up numbers of what the user produces with his solar panels
    // measured in kWh/m2. Each number represents the total produced energy in one day.
    // So the array represents a week. In a real app, this should be some automatic input
    // to the app
    var producedEnergy = [1.25, 1.00, 1.00, 2.00, 1.2, 1.5, 0.89]
    
    // View of the phone
    var body: some View {
        
        ZStack {
            
            Image("appBackground").ignoresSafeArea()
            
            // Verticle stack of three graphs. All the graphs shows data limited to one week.
            // In a real app, the user should be able to choose what interval to view.
            // For example monthly or annually.
            VStack {
                
                Text("Umeå, Sweden")
                Text("20-26 september")
                Text("kWh/m2")

                // The first graph displays solar radience from the API, corresponding
                // to 20 - 26 september 2020.
                BarChartView(data: ChartData(points:
                [(stringToDouble(from: weatherDataUme[0].energy)),
                 (stringToDouble(from: weatherDataUme[1].energy)),
                 (stringToDouble(from: weatherDataUme[2].energy)),
                 (stringToDouble(from: weatherDataUme[3].energy)),
                 (stringToDouble(from: weatherDataUme[4].energy)),
                 (stringToDouble(from: weatherDataUme[5].energy)),
                 (stringToDouble(from: weatherDataUme[6].energy))
                ]), title: "Solar radiance 2020", form: ChartForm.large, dropShadow: false)
            
                // The second graph displays the last seven days produced energy,
                // corresponding to 20 - 26 september 2021.
                BarChartView(data: ChartData(points:
                [producedEnergy[0],
                 producedEnergy[1],
                 producedEnergy[2],
                 producedEnergy[3],
                 producedEnergy[4],
                 producedEnergy[5],
                 producedEnergy[6]
                ]), title: "Produced energy 2021", form: ChartForm.large, dropShadow: false)

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
