import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.rx.text.map({text in
            
            if !text!.contains("@") || !text!.contains(".") {
                return "Неверный Email"
            } else {
                self.passwordTextfield.isEnabled = true
                return "Введите пароль"
            }
            
        }).bind(to: label.rx.text)
        
        passwordTextfield.rx.text.map({ text in
            
            switch text!.count {
            case 0: return ""
            case (1...5): self.button.isEnabled = false; return "Слишком короткий пароль"
            default:
                self.button.isEnabled = true
                return "Succes!"
            }
            
        }).bind(to: label.rx.text)
    }
}



