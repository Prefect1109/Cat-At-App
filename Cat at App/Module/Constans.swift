import Foundation

//MARK: - Constants

struct K {
    
    // Run time cache - breeds info
    static var breedsList = [Breed]()
    
}

//MARK: - Segue

struct Segue {
    
    static var finalViewSegueName = "goToFinal"
    static var goToBreedList = "goToBreedList"
    static var goToQuiz = "goToQuiz"
    static var goToQuizMainView = "goToQuizMainView"
    static var goToOneBreedList = "goToOneBreedList"
    
}

//MARK: - CellID

struct CellID {
    
    static let catBreedCell = "newCatBreedCell"//"catBreedCell"
    static let catBreedCellClass = "BreedTableViewCell"//"BreedTableViewCell"
    
}
