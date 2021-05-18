import UIKit
import RxCocoa
import RxSwift


class SecondViewController: UIViewController {
    @IBOutlet weak var searchTextfield: UITextField!
    let bag = DisposeBag()
    let searchTextfieldText = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextfield.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe ({ text in
            print(text)
        }).disposed(by: bag)
    }
}
