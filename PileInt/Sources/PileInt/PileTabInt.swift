struct PileTabInt: PileIntProtocol {

    //! Attributs stockés (variables)
    private var elements : [Int]
    private var sommet : Int //position du prochain element à empiler

    //
    // [ ][ ][ ][ ][ ][ ] = elements
    //        |
    //      sommet

    //! Propriétés calculées (getters)

    /*
    Indique si la pile est vide
    - Returns: Vrai si la pile est vide, faux sinon
    */
    public var isEmpty : Bool
    {
        return self.sommet <= 0
    }

    /*
    Donne la valeur en haut de la pile
    - Returns: La valeur en haut de la pile
    */
    public var top : Int?
    {
        return self.sommet >= 1 ? self.elements[self.sommet-1] : nil
    }

    /*
    Indique si la pile est pleine
    - Returns: Vrai si la pile est pleine, faux sinon
    */
    public var isFull : Bool
    {
        return self.count == self.capacity
    }

    /*
    Donne le nombre d'éléments dans la pile
    - Returns: Le nombre d'éléments
    */
    public var capacity : Int{
        return self.elements.count
    }

    /*
    Donne le nombre d'éléments dans la pile
    - Returns: Le nombre d'éléments
    */
    public var count : Int
    {
        return self.sommet
    }

    //! Fonctions

    /*
    Initialise la pile avec une capacité donnée
    - Parameter capacity: La capacité de la pile
    */
    init(capacity: Int)
    {
        self.elements = [Int](repeating: 0, count: capacity)
        self.sommet = 0
    }

    /*
    Ajoute un élément à la pile
    - Parameter value: La valeur à ajouter
    */
    public mutating func push(value : Int)
    {
        guard !isFull else
        {
            fatalError("La pile est pleine")
        }
        self.elements[self.sommet] = value
        self.sommet += 1
    }

    /*
    Retire un élément de la pile
    - Returns: La valeur retirée
    */
    public mutating func pop() -> Int? // Note: le self ici n'est pas obligé, c'est pour faire Pile.pop().pop()...
    {
        guard !isEmpty else {
            fatalError("La pile est vide")
        }
        let value: Int? = top
        self.sommet -= 1
        return value
    }
}