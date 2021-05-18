import UIKit
import RxSwift
import RxCocoa

class FourthViewController: UIViewController {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberButton: UIButton!
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "\(number)"
    
        numberButton.rx.tap.map({
            self.number += 1
            return "\(self.number)"
        }).bind(to: numberLabel.rx.text)
    }
}
