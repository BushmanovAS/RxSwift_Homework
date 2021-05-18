import UIKit
import RxCocoa
import RxSwift

class SixViewController: UIViewController {
    @IBOutlet weak var sixTableView: UITableView!
    @IBOutlet weak var searchTextfield: UITextField!
    let names = BehaviorRelay(value: ["Bob", "Bob1","Bob2","Bob3","Bob4","Bob5","Bob6","Bob7","Bob8","Bob9","Bob10","Bob11","Bob12","Bob13","Bob14","Bob15","Bob16","Bob17","Bob18","Bob19","Bob20"])
    let filtredNames = BehaviorRelay(value: ["1"])
    let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let searchResult =  searchTextfield.rx.text
                 .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                 .flatMapLatest { text -> BehaviorRelay<[String]> in
                    
                    if text == "" {
                         return self.names
                     } else {
                        let filterMetod = self.names.value                        
                        self.filtredNames.accept(filterMetod.filter{$0.contains(text!)})
                        print(self.filtredNames.value)
                        return self.filtredNames
                     }
                    
                 }.observe(on: MainScheduler.instance)
            
            searchResult
                .bind(to: sixTableView.rx.items) { (tableView, row, element) in
                    let cell = self.sixTableView.dequeueReusableCell(withIdentifier: "SixCell") as! SixTableViewCell
                    cell.cellLable.text = element
                    return cell
                }.disposed(by: disposeBag)
            
            sixTableView.rx
                .itemSelected
                .subscribe(onNext: { indexPath in
                    self.sixTableView.deselectRow(at: indexPath, animated: true)
                })
                .disposed(by: disposeBag)
        }
}
