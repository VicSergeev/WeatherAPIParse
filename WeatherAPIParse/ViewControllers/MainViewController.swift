//
//  ViewController.swift
//  WeatherAPIParse
//
//  Created by Vic on 29.01.2024.
//

import UIKit

enum Link {
    case metarURL
    case tafURL
    
    var url: URL {
        switch self {
        case .metarURL:
            return URL(string:"https://aviationweather.gov/api/data/metar?ids=URRP&format=json&taf=false&hours=1&date=20240130_113306Z")!
        case .tafURL:
            return URL(string:"https://aviationweather.gov/api/data/taf?ids=URRP&format=json&metar=false&date=20240130_113306Z")!
        }
    }
}

final class MainViewController: UIViewController {
    @IBOutlet var forecastDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMetar()
        fetchTaf()
    }
    @IBAction func getTafAction(_ sender: UIButton) {
        fetchTaf()
    }
    
    @IBAction func getMetarAction(_ sender: UIButton) {
        fetchMetar()
    }
}


// MARK: - Networking
extension MainViewController {
    private func fetchMetar() {
        URLSession.shared.dataTask(with: Link.metarURL.url) { (data, _, error) in
            guard let data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            
            do {
                let forecast = try JSONDecoder().decode([Metar].self, from: data)
                print("METAR RAW DATA\(forecast)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func fetchTaf() {
        URLSession.shared.dataTask(with: Link.tafURL.url) { (data, _, error) in
            guard let data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            
            do {
                let forecast = try JSONDecoder().decode([Taf].self, from: data)
                print("TAF RAW DATA\(forecast)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
