import UIKit
import RxCocoa
import RxSwift

class ThirdViewController: UIViewController {
    @IBOutlet weak var thirdTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton! 
    let names = BehaviorRelay(value: ["Кирилл", "Матвей", "Василий", "Яков", "Тимофей", "Василий", "Иван"])
    let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            names
                .bind(to: thirdTableView.rx.items) { (tableView, row, element) in
                    let cell = self.thirdTableView.dequeueReusableCell(withIdentifier: "ThirdCell") as! ThirdTableViewCell
                    cell.cellLabel.text = element
                    return cell
                }.disposed(by: disposeBag)
            
            thirdTableView.rx
                .itemSelected
                .subscribe(onNext: { indexPath in
                    self.thirdTableView.deselectRow(at: indexPath, animated: true)
                })
                .disposed(by: disposeBag)
        }
        
        @IBAction func addButton(_ sender: Any) {
           names.accept(["Новое имя"] + names.value)
        }

    @IBAction func deleteButton(_ sender: Any) {
        var newArray = names.value
        
        if newArray.isEmpty {
        return
        } else {
            newArray.removeLast()
            names.accept(newArray)
        }
    }
}
