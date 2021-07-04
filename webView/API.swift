//
//  API.swift
//  webView
//
//  Created by soron2 on 3/7/21.
//

import Foundation


final class API{
    
    var endpoint = "https://pre.lafinestrasulcielo.es/api/navtabs?ws_key=Y6IF6GML3NM8FZKX9292EPBB8VSKDM4N&output_format=JSON"
    
    func getNavBar(completion: @escaping (Result<[NavTabsData], Errores>)  -> Void) {
        
        
        let url = URL(string: endpoint)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
                    
            if error != nil {
                print(Errores.invalidResponse)
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                print(Errores.invalidData)
                completion(.failure(.invalidData))
                return
            }
            

            do {
                let decoder = JSONDecoder()
                let navBar = try decoder.decode([NavTabsData].self, from: data)
                
                print("DATA \(String(describing: navBar))")
                completion(.success(navBar))
            } catch {
                print(Errores.invalidData)
                completion(.failure(.invalidData))
            }
            
        }.resume()
        
    }
    
    
    struct NavTabsData: Codable {
        let id: Int
        let label: String?
        let icon: String?
        let url: String?
    }

    
}





enum Errores: String, Error {
    case invalidResponse = "Error en la llamada a la API"
    case invalidDataFormat = "El formato de los datos recibidos es incorrecto"
    case invalidData = "Error al recibir los datos"
}
