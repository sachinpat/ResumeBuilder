

import UIKit

class InvoiceComposer: NSObject {

    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "invoice", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "single_item", ofType: "html")
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "last_item", ofType: "html")
    
    
    let dueDate = ""
    

    var invoiceNumber: String!
    
    var pdfFilename: String!
    
    
    override init() {
        super.init()
    }
    
    
    
    func renderInvoice(personalInfo:PersonalInfo) -> String! {
        // Store the invoice number for future use.
        self.invoiceNumber = "50"
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: DataHolder.sharedInstance.getImage(imageName: "profile.png"))
            
            // Invoice number.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#RESUME_NAME#", with: personalInfo.firstName + personalInfo.lastName)
            
            // Invoice date.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#CONTACT_NUMBER#", with: personalInfo.phoneNumner)
            
            // Due date (we leave it blank by default).
            HTMLContent = HTMLContent.replacingOccurrences(of: "#D_O_B#", with: personalInfo.dateOfBirth)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#Address_Line_1#", with: personalInfo.addressLine1)
            
            // Recipient info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#Address_Line_2#", with: personalInfo.addressLine2.replacingOccurrences(of: "\n", with: "<br>"))
            
            // Payment method.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#EXP_SUMMARY#", with: "Total Experience:" + personalInfo.yearOfExperiece + "years of experince in " + personalInfo.skillSetWorked + "development")
            
            // Total amount.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TOTAL_AMOUNT#", with: "totalAmount")
            
            // The invoice items will be added by using a loop.
            var allItems = ""
            
            // For all the items except for the last one we'll use the "single_item.html" template.
            // For the last one we'll use the "last_item.html" template.
            let items:[[String:String]] = [["price": personalInfo.primaryEducationMarks, "item":"Primary Education"], ["price": personalInfo.secondaryEducationMarks, "item":"Secondary Education"],["price": personalInfo.higherEducationMarks, "item":"Higher Education"]]
            for i in 0..<items.count {
                var itemHTMLContent: String!
                
                // Determine the proper template file.
                if i != items.count - 1 {
                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                }
                else {
                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
                }
                
                // Replace the description and price placeholders with the actual values.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_DESC#", with: items[i]["item"] ?? "")
                
                // Format each item's price as a currency value.
                let formattedPrice = items[i]["price"] //AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: items[i]["price"]!)
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#PRICE#", with: formattedPrice ?? "")
                
                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
            }
            
            // Set the items.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("ResumeBuilder.pdf")
        pdfFilename = "\(getDocDir)/Invoice\(invoiceNumber!).pdf"
        pdfFilename = imagePath
        pdfData?.write(toFile: imagePath, atomically: true)
        
        print(pdfFilename)
    }
    
    func getDocDir() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        for i in 0..<printPageRenderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
}
