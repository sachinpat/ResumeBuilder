//

import UIKit
import MessageUI


class PreviewViewController: UIViewController {

    var resumeWebPreview = UIWebView()
    
    var invoiceInfo: PersonalInfo?
    
    var invoiceComposer: InvoiceComposer!
    
    var HTMLContent: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(resumeWebPreview)
        resumeWebPreview.scalesPageToFit = true
        resumeWebPreview.backgroundColor = .gray
        // Do any additional setup after loading the view.
        resumeWebPreview.translatesAutoresizingMaskIntoConstraints = false
        resumeWebPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        resumeWebPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        resumeWebPreview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        resumeWebPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
        
        let saveBarButtonItem = UIBarButtonItem.init(title: "Show", style: .done, target: self, action: #selector(exportToPDF))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createInvoiceAsHTML()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - Export to PDF
    @objc func exportToPDF() {
        invoiceComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent ?? "")
        showOptionsAlert()
    }
    
    
    // MARK: Custom Methods
    
    func createInvoiceAsHTML() {
        invoiceComposer = InvoiceComposer()
        if let inviceInfoModel = invoiceInfo {
            if let invoiceHTML = invoiceComposer.renderInvoice(personalInfo: inviceInfoModel) {
                
                resumeWebPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: invoiceComposer.pathToInvoiceHTMLTemplate ?? "") as URL?)
                HTMLContent = invoiceHTML
            }
        }
        
    }
    
    
    
    func showOptionsAlert() {
        let alertController = UIAlertController(title: "Yeah!", message: "Your invoice has been successfully printed to a PDF file.\n\nWhat do you want to do now?", preferredStyle: UIAlertControllerStyle.alert)
        
        let actionPreview = UIAlertAction(title: "Preview it", style: UIAlertActionStyle.default) { (action) in
            if let filename = self.invoiceComposer.pdfFilename, let url = URL(string: filename) {
                let request = URLRequest(url: url)
                self.resumeWebPreview.loadRequest(request)
            }
        }
        
        let actionEmail = UIAlertAction(title: "Send by Email", style: UIAlertActionStyle.default) { (action) in
            DispatchQueue.main.async {
                self.sendEmail()
            }
        }
        
        let actionNothing = UIAlertAction(title: "Nothing", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        alertController.addAction(actionPreview)
        alertController.addAction(actionEmail)
        alertController.addAction(actionNothing)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.setSubject("Invoice")
            guard let pdfFilename = invoiceComposer.pdfFilename else { return }
            mailComposeViewController.addAttachmentData(NSData(contentsOfFile: pdfFilename) as! Data, mimeType: "application/pdf", fileName: "Invoice")
            present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
}
