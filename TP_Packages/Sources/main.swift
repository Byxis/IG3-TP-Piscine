import ArgumentParser
import MyUtils
import PileInt

struct MyTool : ParsableCommand {
    @Argument(help:" Nom de l’ utilisateur")
    var name : String

    func run() {
        print ("Bonjour, \(name) !")
    }
}

MyTool.main()
MyUtils.sayHello()
print("Un nombre aléatoire : \(MyUtils.randomInt)")
print("Un nombre aléatoire : \(MyUtils.randomInt)")
print("Un nombre aléatoire : \(MyUtils.randomInt)")


var pile : PileIntProtocol = PileInt.createPile(capacity: 10)

let cap: Int = pile.capacity
for i: Int in 1...cap {
    pile.push(value: i)
}

let count: Int = pile.count
for j: Int in 0...(count-1){
    if let top: Int = pile.top{
        if j == count-1{
            print(top)
        }
        else{
            print(top, terminator: ", ")
        }
    }
    else
    {
        if j == count-1{
            print("nil")
        }
        else{
            print("nil", terminator: ", ")
        }
    }
    _ = pile.pop()
}
