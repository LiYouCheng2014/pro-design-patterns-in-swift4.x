class ControllerBase {
    private let repository:Repository;
    private let nextController:ControllerBase?;
    
    init(repo:Repository, nextController:ControllerBase?) {
        self.repository = repo;
        self.nextController = nextController;
    }
    
    func handleCommand(command:Command, data:[String]) -> View? {
        return nextController?.handleCommand(command: command, data:data);
    }
}

class PersonController : ControllerBase {
    
    override func handleCommand(command: Command, data:[String]) -> View? {
        switch command {
        case .LIST_PEOPLE:
            return listAll();
        case .ADD_PERSON:
            return addPerson(name: data[0], city: data[1]);
        case .DELETE_PERSON:
            return deletePerson(name: data[0]);
        case .UPDATE_PERSON:
            return updatePerson(name: data[0], newCity:data[1]);
        case .SEARCH:
            return search(term: data[0]);
        default:
            return super.handleCommand(command: command, data: data);
        }
    }
    
    private func listAll() -> View {
        return PersonListView(data:repository.People);
    }
    
    private func addPerson(name:String, city:String) -> View {
        repository.addPerson(person: Person(name, city));
        return listAll();
    }
    
    private func deletePerson(name:String) -> View {
        repository.removePerson(name: name);
        return listAll();
    }
    
    private func updatePerson(name:String, newCity:String) -> View {
        repository.updatePerson(name: name, newCity: newCity);
        return listAll();
    }
    
    private func search(term:String) -> View {
        let termLower = term.lowercased();
        let matches = repository.People.filter({ person in
            return person.name.lowercased().range(of: termLower) != nil
                || person.city.lowercased().range(of: termLower) != nil
            
        });
        return PersonListView(data: matches);
    }
}

class CityController : ControllerBase {
    
    override func handleCommand(command: Command, data: [String]) -> View? {
        switch command {
        case .LIST_CITIES:
            return listAll();
        case .SEARCH_CITIES:
            return search(city: data[0]);
        case .DELETE_CITY:
            return delete(city: data[0]);
        default:
            return super.handleCommand(command: command, data: data);
        }
    }
    
    private func listAll() -> View {
        return CityListView(data: repository.People.map({$0.city}).unique());
    }
    
    private func search(city:String) -> View {
        let cityLower = city.lowercased();
        let matches:[Person] = repository.People
            .filter({ $0.city.lowercased() == cityLower });
        return PersonListView(data: matches);
    }
    
    private func delete(city:String) -> View {
        let cityLower = city.lowercased();
        let toDelete = repository.People
            .filter({ $0.city.lowercased() == cityLower });
        for person in toDelete {
            repository.removePerson(name: person.name);
        }
        return PersonListView(data: repository.People);
    }
}
