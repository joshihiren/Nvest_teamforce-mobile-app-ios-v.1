//
//  Extensions.swift
//  TeamForce
//
//  Created by Hiren Joshi on 04/02/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    func roundedview(){
        let maskPath1 = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: Screen_width, height: 90),
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: 90)
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ContainerRelativeShapeSpecificCorner: Shape {
    
    private let corners: [UIRectCorner]
    
    init(corner: UIRectCorner...) {
        self.corners = corner
    }
    
    func path(in rect: CGRect) -> Path {
        var p = ContainerRelativeShape().path(in: rect)
        
        if corners.contains(.allCorners) {
            return p
        }
        
        if !corners.contains(.topLeft) {
            p.addPath(Rectangle().path(in: CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width / 2, height: rect.height / 2)))
        }
        if !corners.contains(.topRight) {
            p.addPath(Rectangle().path(in: CGRect(x: rect.origin.x + rect.width / 2, y: rect.origin.y, width: rect.width / 2, height: rect.height / 2)))
        }
        if !corners.contains(.bottomLeft) {
            p.addPath(Rectangle().path(in: CGRect(x: rect.origin.x, y: rect.origin.y + rect.height / 2, width: rect.width / 2, height: rect.height / 2)))
        }
        if !corners.contains(.bottomRight) {
            p.addPath(Rectangle().path(in: CGRect(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2, width: rect.width / 2, height: rect.height / 2)))
        }
        return p
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

extension String
{
    
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func IsContainCharacter() -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if self.rangeOfCharacter(from: characterset) != nil {
            return true
        }
        return false
    }
    
    func IsContainUppercase() -> Bool {
        let characterset = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if self.rangeOfCharacter(from: characterset) != nil {
            return true
        }
        return false
    }
    
    func IsContainDigit() -> Bool {
        let characterset = CharacterSet(charactersIn: "0123456789.")
        if self.rangeOfCharacter(from: characterset) != nil {
            return true
        }
        return false
    }
    
    func IsContainSpecialCharacter() -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
            return true
        }
        return false
    }
    
    func isValidPassword() -> Bool {
        guard self != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one special character
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: self)
    }
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
    func size(_ font: UIFont) -> CGSize {
        return NSAttributedString(string: self, attributes: [.font: font]).size()
    }
    
    func width(_ font: UIFont) -> CGFloat {
        return size(font).width
    }
    
    func height(_ font: UIFont) -> CGFloat {
        return size(font).height
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var isBlank:Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    var isZero:Bool {
        if self == "0" || self == "" {
            return true
        }
        else {
            return false
        }
    }
    
    
    func IsStrEmpty() -> Bool {
        if self.isEmpty && self.isBlank && self.isZero {
           return true
        }
        else {
            return false
        }
    }
    
    /**
     Convert argument string into localisedstring and display to caller controllers
     ### Usage Example: ###
     ````
     "locatized"
     ````
     */
    func localized() -> String
    {
        return NSLocalizedString(self, comment: self)
    }
    
    func removeWhiteSpace() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        var final = trimmed.replacingOccurrences(of: " ", with: "")
        final = final.replacingOccurrences(of: " ", with: "")
        return final
    }
    
    mutating func replaceLocalized(fromvalue: [String], tovalue: [String]) -> String {
        var replacestr: String = ""
        for (index, from) in fromvalue.enumerated() {
            replacestr = self.replacingOccurrences(of: from, with: tovalue[index])
            self = replacestr
        }
        return self
    }
    
    /**
     convert argument string into Date year format and display to caller controllers
     ### Usage Example: ###
     ````
     "string".currentYear()
     ````
     */
    static func currentYear()->String
    {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "YYYY"
        return myFormatter.string(from: Date())
    }
    
    /**
     convert argument string into Date Month format and display to caller controllers
     ### Usage Example: ###
     ````
     "string".currentMonth()
     ````
     */
    static func currentMonth()->String
    {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM"
        return myFormatter.string(from: Date())
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func CoinPriceThumbRules(Coin: String) -> String? {
        if Coin.uppercased() == "USD".uppercased() || Coin.uppercased() == "USDT".uppercased() || Coin.uppercased() == "CAD".uppercased() {
            return String.init(format: "%@", (self.ConvertIntoUSDFormat())!)
        }
        else {
            return String.init(format: "%@ %@", (self.ConvertOtherCurrencyFormat())!, Coin)
        }
    }
    
    func WithoutCoinPriceThumbRules(Coin: String) -> String? {
        if Coin.uppercased() == "USD".uppercased() || Coin.uppercased() == "USDT".uppercased() || Coin.uppercased() == "CAD".uppercased() {
            return String.init(format: "%@", (self.ConvertIntoUSDFormat())!)
        }
        else {
            return String.init(format: "%@", (self.ConvertOtherCurrencyFormat())!)
        }
    }
    
    func ConvertIntoUSDFormat() -> String? {
        if let n = NumberFormatter().number(from: self) {
            let floatvalue = Double(truncating: n)
            return String.init(format: "%0.2f", floatvalue)
        }
        return "0.00"
    }
    
    func ConvertOtherCurrencyFormat() -> String? {
        if self.contains(".") {
            let array = self.components(separatedBy: ".")
            let value1 = array.first
            let value2 = array.last
            if value1?.count == 0 {
                return String.init(format: "0.%@", (value2!.prefix(4)) as CVarArg)
            }
            else if value1?.count == 1 {
                return String.init(format: "%@.%@", (value1)!, (value2!.prefix(4)) as CVarArg)
            }
            else if value1?.count == 2 {
                return String.init(format: "%@.%@", (value1)!, (value2!.prefix(3)) as CVarArg)
            }
            else if value1?.count == 3 {
                return String.init(format: "%@.%@", (value1)!, (value2!.prefix(2)) as CVarArg)
            }
            else if value1?.count == 4 {
                return String.init(format: "%@.%@", (value1)!, (value2!.prefix(1)) as CVarArg)
            }
            else {
                return value1
            }
        }
        else {
            return self.convertfraction()
        }
    }
    
    func convertfraction() -> String? {
        if let n = NumberFormatter().number(from: self) {
            let floatvalue = Double(truncating: n)
            if self.count == 0 || self.isEmpty {
                return String.init(format: "0.0000")
            }
            else if self.count == 1 {
                return String.init(format: "%0.4f", floatvalue)
            }
            else if self.count == 2 {
                return String.init(format: "%0.3f", floatvalue)
            }
            else if self.count == 3 {
                return String.init(format: "%0.2f", floatvalue)
            }
            else if self.count == 4 {
                return String.init(format: "%0.1f", floatvalue)
            }
            else {
                return String.init(format: "%0.0f", floatvalue)
            }
        }
        return String.init(format: "0.0000")
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func daySuffix(from date: Date) -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    func AddCoinPrefix() -> String {
        if self.hasPrefix("GXT") {
            return self
        }
        else {
            return String.init(format: "GXT%@", self)
        }
    }
    
    func RemoveCoinPrefix() -> String {
        if self.hasPrefix("GXT") {
            var str = self
            return str.replaceLocalized(fromvalue: ["GXT"], tovalue: [""])
        }
        else {
            return self
        }
    }

}

@objc extension UITableView {
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)

        return IndexPath(row: row, section: section)
    }
    
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
    }
    
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0) {
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
    
}

extension NSDictionary {
   var DictToqueryString: String {
      var output: String = ""
      for (key,value) in self {
          output +=  "\(key)=\(value)&"
      }
      output = String(output.dropLast())
      return output
   }
    
    func keyedOrNilValue(key: Key) -> Any? {
        return self[key] ?? "" as Any
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension Double {
    func getDateStringFromUTC(format: String = "EEEE, MMM d, yyyy") -> String {
        let date = Date(timeIntervalSince1970: self / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let STRdate = dateFormatter.string(from: date)
        let dt = STRdate.components(separatedBy: ", ")
        let final = String.init(format: "%@, %@%@, %@", dt[0], dt[1], STRdate.daySuffix(from: date), dt[2])
        return final
    }
    
    func getFormattedDate(strDate: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter

        let date: Date? = dateFormatterGet.date(from: strDate)
        print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!);
    }
}
