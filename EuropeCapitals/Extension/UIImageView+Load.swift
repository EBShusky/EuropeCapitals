import UIKit

extension UIImageView {

    func load(url: String) {
        DispatchQueue.global().async {
            let url = URL(string: url)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}
