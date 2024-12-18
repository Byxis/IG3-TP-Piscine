
# TP : Utilisation des Packages Swift avec Swift Package Manager (SPM)

Ce TP a pour but :
- Comprendre l’organisation des packages Swift ;
- Apprendre à utiliser Swift Package Manager (SPM) pour gérer des packages ;
- Créer et utiliser un package local ;
- Ajouter des packages tiers dans un projet.

## Navigation

- [Prérequis](#prérequis)

- [Questions / Réponses](#questions--réponses)
  - [Étape 1 : Initialisation d’un projet Swift](#étape-1--initialisation-dun-projet-swift)
  - [Étape 2 : Ajout d’un package tiers](#étape-2--ajout-dun-package-tiers)
  - [Étape 3 : Création d’un package local](#étape-3--création-dun-package-local)
  - [Étape 4 : Questions](#étape-4--questions)
  - [Étape 5 : Exercice supplémentaire](#étape-5--exercice-supplémentaire)
  - [Étape 6 : Package Pile](#étape-6--package-pile)

- [Auteur](#auteur)

## Prérequis

Ce projet nécessite les choses suivantes :
- Swift installé sur Linux (voir instructions d’installation sur https://swift.org/download/) ;
-  Un terminal de commande fonctionnel ;
-  Connaissance de base du langage Swift 😎.

## Questions / Réponses

### Étape 1 : Initialisation d’un projet Swift
1. Cela m'initialise le projet Swift.

```
mkdir TP_Packages
cd TP_Packages
swift package init -- type executable
```

2. Structure du projet :
- Package.swift : fichier de configuration ;
- Sources/ : code source ;
- Tests/ : tests unitaires
4. Le projet compile et run : je reçois bien le message de bienvenue.

### Étape 2 : Ajout d’un package tiers

1. J'ajoute dans mon fichier Package.swift :
```
import PackageDescription

let package = Package(
    name: "TP_Packages",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "TP_Packages",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
```
Cela permet d'importer l'ArgumentParser, permettant de passer des paramètres lors de l'execution avec swift run.

2. Afin d'utiliser l'**ArgumentParser**, j'ajoute ce code dans mon fichier main.swift
```
import ArgumentParser

struct MyTool : ParsableCommand {
    @Argument(help:" Nom de l’ utilisateur")
    var name : String

    func run() {
        print ("Bonjour, \(name) !")
    }
}

MyTool.main()
```

3. En faisant `swift run TP_Packages Alexis`, je reçois bien sur la console "*Bonjour, Alexis !*"

### Étape 3 : Création d’un package local

1. Pour créer un package local, on sort de notre projet pour un créer un nouveau, de type librairie

```
cd ..
mkdir MyUtils
cd MyUtils
swift package init -- type library -- name MyUtils
```

2. Dans **Sources/MyUtils/MyUtils.swift**, on ajoute :
```
public struct MyUtils {
    public static func sayHello() {
        print("Hello from MyUtils!")
    }
}
```

3. Afin d'inclure le package local dans notre projet initial, il faut rajouter `.package(path: "../MyUtils")` dans les dépendances du Package, et `"MyUtils"` dans les dépendances du target. On obtient alors dans **Package.swift** :
```
import PackageDescription

let package = Package(
    name: "TP_Packages",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.0.0"
        ),
        .package(path: "../MyUtils")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "TP_Packages",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "MyUtils"
            ]
        )
    ]
)
```

4. On ajoute ce bout de code dans **main.swift** afin de le tester. En utilisant `swift run TP_Packages Alexis`, nous avons bien un 2e message qui s'affiche : 
```
Bonjour, Alexis !
Hello from MyUtils!
```

### Étape 4 : Questions

- Pourquoi utiliser des packages dans un projet ?

Les packages permettent d'organiser le code, de réutiliser des composants et de partager du code entre différents projets. Cela permet de rendre le code plus publique et d'éviter les copier-coller entre projets.


- Comment ajouter un package tiers ?

Pour ajouter un package tiers, on doit modifier le fichier `Package.swift` de notre projet pour inclure le package en tant que dépendance. 
Pour un package local, il faut rajouter `.package(path: "../NOM_PACKAGED")` dans les dépendances du Package, et `"NOM_PACKAGED"` dans les dépendances de target.
Pour un package local, il faut rajouter 
```
.package(
    url: "LIEN_PACKAGE",
    from: "VERSION_PACKAGE"
)
``` 
dans les dépendances du Package, et `.product(name: "NOM_PACKAGE", package: "NOM_PACKAGE2")` dans les dépendances de target.

- Comment organiser un projet avec plusieurs packages locaux ?

Il faut créer un premier dossier parent de tous les différents packages. Ensuite, pour chaque grand type ou type utilisé plusieurs fois, créer un package local. Par exemple, dans ce projet, j'ai fait ceci :
```
TP-Piscine/
├── TP_Packages/
│   └── ...
│
├── MyUtils/
│   └── ...
│
└── PileInt/
    └── ...
```

### Étape 5 : Exercice supplémentaire

Afin d'ajouter une fonction dans MyUtils qui génère un nombre aléatoire, on ajoute dans la **MyUtils.swift** : 

```
// Renvoie un nombre aléatoire entre 0 et 100
public static var randomInt: Int {
    return Int.random(in: 0...100)
}
```

Afin de tester le résultat, nous allons ajouter un print dans le **main.swift** de notre projet principal :

```
print("Un nombre aléatoire : \(MyUtils.randomInt)")
```

En executant le projet principal en utilisant `swift run TP_Packages Alexis`, nous avons bien un 3e message qui s'affiche : 

```
Bonjour, Alexis !
Hello from MyUtils!
Un nombre aléatoire : 51
```
En executant plusieurs fois le projet principal, on remarque que le nombre change bien.

### Étape 6 : Package Pile

#### Création du package

Afin de créer un package de type library du type PileInt vu en cours, executons les commandes suivantes : 
```
cd ..
mkdir PileInt
cd PileInt/
swift package init --type library --name PileInt
```

Ensuite, pour créer le fichier de **PileIntProtocol** et de **PileTabInt**, on fait :
```
cd Sources/PileInt/
touch PileIntProtocol.swift
touch PileTabInt.swift
```

#### Implémentation du protocol, du struct et ajout des tests

On implémente le protocol et la struct comme vu en cours dans leurs fichiers respectifs.

Ensuite, dans le fichier **PileInt/Tests/PileIntTests/PileIntTests.swift**, on supprime la fonction testExample() et on la remplace par nos tests. J'ai décidé de réaliser les tests suivant :
- **Test d'initialisation** :  on vérifie que les valeurs par défauts d'une pile vide sont correctes.
- **Test d'ajout** : on vérifie qu'en ajoutant une valeur, la pile est bien modifié et que les attributs comme top, count, etc... sont corrects.
- **Test de retirement** : on vérifie qu'en ajoutant une valeur puis en l'enlevant, la pile est bien modifié et que les attributs comme top, count, etc... sont corrects.
- **Test de pile remplie** : on vérifie qu'une pile remplie à bien l'attribut `isFull` en `TRUE`.
- **Test de valeur de pile** : on vérifie qu'en réalisant quelques opérations de pop et de push, l'ordre est toujours bon.
- **Test d'extrême** : on vérifie qu'on ne peut pas ajouter quand une pile est pleine ou enlever quand une pile est vide. Je n'implémenterai pas celle-ci, car les fonctions associées renvoient des *fatalError*, qui ne sont pas géré par *XCTest*.

#### Ajout de la struct *PileInt* pour pouvoir l'utiliser en dehors du projet

Afin de pouvoir créer une pile depuis notre TP_Packages, il faut rajouter une structure et une fonction permettant de créer une pile (car PileTabInt est privé) dans le fichier **PileInt.swift**:

```
public struct PileInt {
    public static func createPile(capacity: Int) -> PileIntProtocol {
        return PileTabInt(capacity: capacity)
    }
}
```

On peut maintenant faire un `swift build` et un `swift test` pour s'assurer du bon fonctionnement de notre code.

#### Importation dans un autre projet

Ensuite, nous pouvons l'intégrer dans notre projet TP_Packages en rajoutant `.package(path: "../PileInt")` dans les dépendances du Package, et `"PileInt"` dans les dépendances du target.


Ensuite dans le **main.swift**, on ajoute :

```
import PileInt

...

//Exemple de code utilisant une pile
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

```

Pour tester, se place dans /TP_Packages/ et on effectue les commandes `swift build` et `swift run TP_Packages Alexis`, ce qui nous renvoie :

```
Bonjour, Alexis !
Hello from MyUtils!
Un nombre aléatoire : 9
Un nombre aléatoire : 34
Un nombre aléatoire : 77
10, 9, 8, 7, 6, 5, 4, 3, 2, 1
```

## Auteur

Projet réalisé le 18 décembre 2024 pour un projet Polytech, sur la Programmation Algorithmique en Swift


- [Byxis](https://github.com/Byxis)

