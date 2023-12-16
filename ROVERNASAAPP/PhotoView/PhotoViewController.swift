import UIKit

class PhotoViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var copyrigthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        animateLoader(isAnimating: true)
        fetchPhotoInfo()
    }
    

    private func setUpUI(){
        self.title = "Daily photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        postImageView.image = UIImage(named: "placeHolderImage")
        loaderView.stopAnimating()
        loaderView.isHidden = true
        titleLabel.text = "..."
        dateLabel.text = "..."
        copyrigthLabel.text = "..."
    }
    
    private func animateLoader(isAnimating: Bool){
        DispatchQueue.main.async{
            self.loaderView.isHidden = !isAnimating
            if isAnimating{
                self.loaderView.startAnimating()
            }else{
                self.loaderView.stopAnimating()
            }
        }
    }
    
    private func fetchPhotoInfo(){
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                let jsonDecoder = JSONDecoder()
                guard let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) else { return }
                self.displayPhotoInfo(photoInfo: photoInfo)
                self.fetchImage(url: photoInfo.imageURL)
            }
            
        }
        task.resume()
    }
    
    private func fetchImage(url: String){
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                guard let image = UIImage(data: data) else { return }
                self.displayImage(image: image)
                self.animateLoader(isAnimating: false)
            }
        }
        task.resume()
    }
    
    private func displayPhotoInfo(photoInfo: PhotoInfo){
        DispatchQueue.main.async {
            self.titleLabel.text = photoInfo.title
            self.dateLabel.text = photoInfo.date
            self.postTextView.text = photoInfo.description
            self.copyrigthLabel.text = photoInfo.copyright
        }
        
    }
    private func displayImage(image: UIImage){
        DispatchQueue.main.async{
            self.postImageView.image = image
        }
    }

}

