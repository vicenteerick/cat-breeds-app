import UIKit

final class PickerViewDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    private let data: [String]
    @Published private(set) var selectedText: String?

    init(data: [String]) {
        self.data = data
        selectedText = data.first
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedText = data[row]
    }
}
