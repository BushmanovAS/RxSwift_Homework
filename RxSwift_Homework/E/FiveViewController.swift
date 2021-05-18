import UIKit
import RxCocoa
import RxSwift

class FiveViewController: UIViewController {
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    var first = false
    var second = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstButton.rx.tap.map({ () -> String in
            self.first = true
            
            if self.first == true, self.second == true {
                return "Rocket Start! 🚀 "
            } else {
                return "-"
            }
            
        }).bind(to: rocketLabel.rx.text)
        
        secondButton.rx.tap.map({ () -> String in
            self.second = true
            
            if self.first == true, self.second == true {
                return "Rocket Start! 🚀 "
            } else {
                return "-"
            }
            
        }).bind(to: rocketLabel.rx.text)
    }
}
