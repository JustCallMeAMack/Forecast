import SwiftUI

struct ContentView: View {
@State private var isNight = false
    let forecast: [FiveDayForecast] = [
        FiveDayForecast(day: .wednesday, icon: .sunny , temp: "74°F"),
        FiveDayForecast(day: .thursday, icon: .partial, temp: "68°F"),
        FiveDayForecast(day: .friday, icon: .rainy, temp: "62°F"),
        FiveDayForecast(day: .saturday, icon: .thunder, temp: "58°F"),
        FiveDayForecast(day: .sunday, icon: .rainy, temp: "60°F"),
    ]
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [isNight ? Color("nightfall") :.blue, isNight ? .gray : .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea(edges: .all)
            VStack {
                Text("Austin, TX")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .padding()

                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: isNight ? "moon.stars.fill" : "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 180, height: 150)
                        .padding()
                    
                    Text("Tue")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .medium, design: .default))
                    
                    Text("76°F")
                        .foregroundStyle(.white)
                        .font(.system(size: 48, weight: .bold, design: .default))
                        .padding()
                }
                Spacer()
            HStack {
               
                ForEach (forecast) { forecast in
                    VStack {
                        Text(forecast.day.rawValue)
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .padding()
                        HStack {
                            Image(systemName: forecast.icon.rawValue)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Text(forecast.temp)
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .medium, design: .default))
                        Spacer()
                    }
                }
            }
        }
            .padding()
        }
        .onAppear {
            let hour = Calendar.current.component(.hour, from: Date())
            isNight = hour >= 19 || hour <= 7
        }
    }
}

struct FiveDayForecast: Identifiable {
    let id = UUID()
    var day: ThisWeek
    var icon: ImageName
    var temp: String
    
}

enum ThisWeek: String, CaseIterable {
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
}

enum ImageName: String {
    case sunny = "sun.max.fill"
    case cloudy = "cloud.fill"
    case rainy = "cloud.drizzle.fill"
    case thunder = "cloud.bolt.rain.fill"
    case partial = "cloud.sun.fill"
}




#Preview {
    ContentView()
}
