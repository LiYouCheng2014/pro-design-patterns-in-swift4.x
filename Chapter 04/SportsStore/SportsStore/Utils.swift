import Foundation;

@available(iOS 9.0, *)
class Utils {
    
    class func currencyStringFromNumber(number:Double) -> String {
        let formatter = NumberFormatter();
        formatter.numberStyle = .currencyAccounting;
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
