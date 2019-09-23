//
//  CreateProjectViewController.swift
//  project-tracker-post-requests
//
//  Created by Mr Wonderful on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        guard let project = createProjectFromFields() else {
            //TODO: error... maybe a pop-up
            return
        }
        
        ProjectAPIClient.manager.postProject(project: project) { (result) in
            switch result {
            case .success(let success):
                self.navigationController?.popViewController(animated: true)
            //we could do something with the data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: Lifecycle Functions
  
    
    //MARK: Private
    private func createProjectFromFields() -> Project? {
        guard let name = nameTextField.text else {
            return nil
        }
        return Project(dueDate: formatAirTableDate(date: datePicker.date), name: name )
    }
    
    private func formatAirTableDate(date: Date) -> String {
        return date.description.components(separatedBy: .whitespaces)[0]
    }
}
