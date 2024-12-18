public protocol PileIntProtocol {

    /*
    Initialise la pile avec une capacité donnée
    - Parameter capacity: La capacité de la pile
    */
    init(capacity: Int) //init: Int -> StackT

    /*
    Donne la valeur en haut de la pile
    - Returns: La valeur en haut de la pile
    */
    var top: Int? { get } //top: StackT -> Int | Vide

    /*
    Ajoute un élément à la pile
    - Parameter value: La valeur à ajouter
    */
    mutating func push(value : Int)//push: StackT * Int -> StackT

    /*
    Retire un élément de la pile
    - Returns: La valeur retirée
    */
    mutating func pop() -> Int? //pop: PStackInt -> PStackInt | Vide
    
    /*
    Indique si la pile est vide
    - Returns: Vrai si la pile est vide, faux sinon
    */
    var isEmpty: Bool {get} //isEmpty: StackT -> Bool

    /*
    Indique si la pile est pleine
    - Returns: Vrai si la pile est pleine, faux sinon
    */
    var isFull: Bool {get} //isFull: StackT -> Bool

    /*
    Donne le nombre d'éléments dans la pile
    - Returns: Le nombre d'éléments
    */
    var capacity: Int {get} //capacity: StackT -> Int

    /*
    Donne le nombre d'éléments dans la pile
    - Returns: Le nombre d'éléments
    */
    var count: Int {get} //count: StackT -> Int
}