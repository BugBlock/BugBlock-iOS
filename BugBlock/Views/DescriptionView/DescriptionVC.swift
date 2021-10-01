//
//  DescriptionVC.swift
//  BugBlock
//
//  Created by Vadym Kozak on 29.08.2021.
//

import UIKit

class DescriptionVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var screenshotImageView: UIImageView!
    var image: UIImage?
    private var reporter: BugReporterProtocol
    
    
    public init(reporter: BugReporterProtocol) {
        self.reporter = reporter
        super.init(nibName: "DescriptionVC", bundle: Bundle(for: DescriptionVC.self))
        self.reporter.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Report a bug"
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
        
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closeKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
            
        bar.items = [flexibleSpace, reset]
        bar.sizeToFit()
        descriptionTextView.inputAccessoryView = bar
        descriptionTextView.contentInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        emailTextField.inputAccessoryView = bar
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        
        self.screenshotImageView.image = image
        
        self.emailTextField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.userEmail.rawValue)
    }

    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }

    @IBAction func send(_ sender: Any) {
        self.emailTextField.layer.borderWidth = 0
        guard let email = self.emailTextField.text, email.isValidEmail() else {
            self.emailTextField.layer.borderWidth = 1
            self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        UserDefaults.standard.setValue(self.emailTextField.text, forKey: UserDefaultsKeys.userEmail.rawValue)
        self.reporter.report(email: email, description: self.descriptionTextView.text, image: image)
    }
}

extension DescriptionVC: BugReporterDelegate {
    func bugReported() {
        print("Bug reported")
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
