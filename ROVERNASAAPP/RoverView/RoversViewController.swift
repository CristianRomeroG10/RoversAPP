//
//  RoversViewController.swift
//  ROVERNASAAPP
//
//  Created by Cristian guillermo Romero garcia on 04/12/23.
//

import UIKit

class RoversViewController: UIViewController {
    
    var photo: [PhotoRover] = []

    
    @IBOutlet weak var roversTableView: UITableView!{
        didSet{
            roversTableView.register(UINib(nibName: "RoversTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mars photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchPhotosInfo()
        roversTableView.dataSource = self
        roversTableView.delegate = self
    

    }
    
    private func fetchPhotosInfo(){
        let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                print("DATA: \(data)")
                print("STRING: \(String(decoding: data, as: UTF8.self))")
                self.decodeJsonResponse(data: data)
            }
            if let response = response{
                print("RESPONSE: \(response)")
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP CODE: \(httpResponse.statusCode)")
                }
            }
            if let error = error{
                print("ERROR: \(error)")
            }
        }
        task.resume()
    }
    
    private func decodeJsonResponse(data: Data){
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(Photos.self, from: data)
            print("DECODE RESPONSE: \(response)")
            photo = response.photos
            
            reloadTableView()
        }catch{
            print("ERROR: \(error)")
        }
    }
    func reloadTableView(){
        DispatchQueue.main.async{
            self.roversTableView.reloadData()
        }
    }
    
    
}

extension RoversViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! RoversTableViewCell
        cell.idLabel.text = String(photo[indexPath.row].id)
        cell.roverLabel.text = photo[indexPath.row].rover.name
        cell.cameraNameLabel.text = photo[indexPath.row].camera.name
        cell.earthDateLabel.text = photo[indexPath.row].camera.full_name
        
        let urlString = photo[indexPath.row].image
        guard let url = URL(string: urlString) else {return cell}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                guard let image = UIImage(data: data) else {return}
                DispatchQueue.main.async{
                    cell.roverImage.image = image
                }
            }
        }
        task.resume()
        return cell
    }
    
    
}

extension RoversViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

