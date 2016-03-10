//
//  MasterViewController.swift
//  WordScramble.Project5
//
//  Created by User on 3/8/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import UIKit
import GameplayKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "promptForAnswer")
        
        if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath, usedEncoding: nil) {
                allWords = startWords.componentsSeparatedByString("\n")
            }
        } else {
            allWords = ["silkworm"]
        }
        
        startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }
    
    func startGame() {
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer() {
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, ac] (action: UIAlertAction!) in
            
            let answer = ac.textFields![0]
            self.submitAnswer(answer.text!)
    }
        
        ac.addAction(submitAction)
        
        presentViewController(ac, animated: true, completion: nil)

    }
    
    func submitAnswer(answer: String) {
        
        let lowerAnswer = answer.lowercaseString
        
        if wordIsPossible(lowerAnswer) {
            if wordIsOriginal(lowerAnswer) {
                if wordIsReal(lowerAnswer) {
                    objects.insert(answer, atIndex: 0)
                    
                    let indexPAth = NSIndexPath(forRow: 0, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPAth], withRowAnimation: .Automatic)
                }
            }
        }
    }
    
    func wordIsPossible(word: String) -> Bool {
        
        return true
    }
    
    func wordIsOriginal(word: String) -> Bool {
        
        return !objects.contains(word)
    }
    
    func wordIsReal(word: String) -> Bool {
        
        return true
    }

}