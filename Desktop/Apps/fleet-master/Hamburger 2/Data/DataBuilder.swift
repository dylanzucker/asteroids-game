//
//  DataBuilder.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/6/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation

class DataBuilder {
    
    //allPeople is connected people, searchPeople is not connected people
    var allPeople = [Person]()
    var allGroups = [Group]()
    var searchPeople = [Person]()
    var searchGroups = [Group]()
    var allNotifications = [Notification]()
    
    init? () {
        self.loadData()
    }
    
    //parses csv string (face palm)
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func buildPersonListFromCsvData(csvdata: String) -> [Person] {
        let data = csv(data: csvdata)
        
        var people = [Person]()
        
        data.forEach { row in
            let phone = row[3].replacingOccurrences(of: " ", with: ".").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            let name = row[0].replacingOccurrences(of: "  ", with: " ")
            guard let newPerson = Person(name: name, username: row[1], bio: row[2], phone: phone, email: row[4], facebook: row[5], photo_key: row[6]) else {
                NSLog("an error occured")
                return
            }
            people += [newPerson]
        }
        return people
    }
    
    func buildGroup(groupCsvLine: String, people: [Person]) -> Group {
        let columns = groupCsvLine.components(separatedBy: ",")
        //columns: name, username, bio, photo_key
        return Group(name: columns[0], username: columns[1], bio: columns[2], photo_key: columns[3], people: people)!
    }
    
    func getPersonByUsername(username: String) -> Person? {
        var returnPerson: Person? = nil
        allPeople.forEach { (person) in
            if person.username == username {
                returnPerson = person
            }
        }
        return returnPerson
    }
    
    func peopleFromCsvArray(data: [[String]]) -> [Person] {
        var people = [Person]()
        data.forEach { row in
            if (row.count != 7) { //skip over bad data
                return
            }
            let phone = row[3].replacingOccurrences(of: " ", with: ".").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            let name = row[0].replacingOccurrences(of: "  ", with: " ")
            guard let newPerson = Person(name: name, username: row[1], bio: row[2], phone: phone, email: row[4], facebook: row[5], photo_key: row[6]) else {
                NSLog("an error occured")
                return
            }
            people += [newPerson]
        }
        return people
    }
    
    //returns whether or not username is connected to my user
    //for demo purposes right now, this is very simple obv
    func isConnectedToMe(username: String) -> Bool {
        var found = false
        allPeople.forEach { (person) in
            if (person.username == username) {
                found = true
            }
        }
        return found
    }
    
    func isMemberOf(username: String, group: Group) -> Bool {
        var ret = false
        group.people?.forEach({ (person) in
            if person.username == username {
                ret = true
            }
        })
        return ret
    }
    
    //connects the user @username to my user
    //this will change thier appearence in search and add them to the contacts list
    func connectToMe(username: String) {
        var indexToRemove = -1
        for (index, person) in searchPeople.enumerated() {
            if person.username == username {
                indexToRemove = index
                break;
            }
        }
        if (indexToRemove == -1) {
            return
        }
        let person = searchPeople[indexToRemove]
        searchPeople.remove(at: indexToRemove)
        allPeople += [person]
        allPeople = allPeople.sorted(by: key)
    }
    
    func disconnectToMe(username: String) {
        var indexToRemove = -1
        for (index, person) in allPeople.enumerated() {
            if person.username == username {
                indexToRemove = index
                break;
            }
        }
        if (indexToRemove == -1) {
            return
        }
        let person = allPeople[indexToRemove]
        allPeople.remove(at: indexToRemove)
        searchPeople += [person]
        searchPeople = searchPeople.sorted(by: key)
    }
    
    func key(one: Person, two:Person) -> Bool {
        return one.name < two.name
    }
    
    func groupsFromCsv(data: [[String]]) -> [Group] {
        var ret = [Group]()
        data.forEach { (row) in
            if (row.count != 5) { //skip over bad data
                return
            }
            var people = [Person]()
            let usernames = row[4].components(separatedBy: "-")
            usernames.forEach({ (username) in
                let person = getPersonByUsername(username: username)
                if person != nil {
                    people += [person!]
                }
            })
            let newGroup = Group(name: row[0], username: row[1], bio: row[2], photo_key: row[3], people: people)!
            ret += [newGroup]
        }
        return ret
    }
    
    func loadData() {
        let actualData = ActualData()
        
        let data = csv(data: actualData.peopleCsv)
        allPeople += peopleFromCsvArray(data: data)
        
        let searchData = csv(data: actualData.searchCsv)
        searchPeople += peopleFromCsvArray(data: searchData)
        
        let groups = csv(data: actualData.groupCsv)
        allGroups += groupsFromCsv(data: groups)
        
        let searchGroupsData = csv(data: actualData.groupSearchCsv)
        searchGroups = groupsFromCsv(data: searchGroupsData)
        
        let notifications = csv(data: actualData.notificationCsv)
        //mainText,timeText,username
        notifications.forEach { (row) in
            if (row.count != 5) {
                return
            }
            let username = row[2]
            let person = getPersonByUsername(username: username)
            let newNotification = Notification(mainText: row[0], username: row[2], timeString: row[1], photo_key: row[3], person: person, platform: row[4])
            allNotifications += [newNotification!]
        }
    }
    
    func addGroup(withUsername username: String, ofGroup group: Group) {
        var indexToRemove = -1
        for (index, group) in searchGroups.enumerated() {
            if group.username == username {
                indexToRemove = index
                break;
            }
        }
        if (indexToRemove == -1) {
            return
        }
        searchGroups.remove(at: indexToRemove)
        
        allGroups.append(group)
        allGroups = allGroups.sorted(by: groupKey)
    }
    
    func removeGroup(withUsername username: String, ofGroup group: Group) {
        var indexToRemove = -1
        for (index, group) in allGroups.enumerated() {
            if group.username == username {
                indexToRemove = index
                break;
            }
        }
        if (indexToRemove == -1) {
            return
        }
        allGroups.remove(at: indexToRemove)
        
        searchGroups.append(group)
        searchGroups = searchGroups.sorted(by: groupKey)
    }
    
    func groupKey(one: Group, two:Group) -> Bool {
        return one.name < two.name
    }
    
}
