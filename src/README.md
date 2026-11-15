# Documentor

Un outil d'analyse de code pour Pharo qui génère un rapport au format Microdown sur une classe donnée.

## Installation

Pour installer ce projet dans votre image Pharo, exécutez l'expression Metacello suivante dans un Playground :

```smalltalk
Metacello new
    baseline: 'Documentor';
    repository: 'github://HarijaoMioty/Documentor/src';
    load.

## Utilisation

1. Rapport de base (Documentor)
Pour générer un rapport détaillé sur une classe (par exemple OrderedCollection), exécutez :

(Documentor on: OrderedCollection) report

Cela générera un rapport Microdown contenant :

Le nom de la classe

Le premier paragraphe de son commentaire

Sa position dans la hiérarchie

Ses variables d'instance (champs)

Son package

Des métriques (profondeur d'héritage, nombre de méthodes, etc.)

La liste des méthodes et de leurs commentaires

2. Linter (DocumentorLinter)
Pour analyser les mauvaises pratiques et la complexité du code d'une classe, exécutez :

(DocumentorLinter on: OrderedCollection) report

Cela générera un rapport listant :

Les méthodes n'utilisant ni self ni les variables d'instance

Les méthodes n'utilisant pas les variables d'instance

La complexité cyclomatique totale de la classe

## test

Le projet contient des tests unitaires pour valider le bon fonctionnement du code.
Pour les lancer, ouvrez le Test Runner de Pharo ou exécutez DocumentorTest suite run.


**Ce que tu dois faire :**
1. Copie ce texte.
2. Va sur la page de ton dépôt GitHub.
3. Clique sur le fichier `README.md`.
4. Clique sur l'icône en forme de **crayon** (Edit this file).
5. Efface tout ce qu'il y a et colle ce nouveau texte.
6. En bas de la page, clique sur **`Commit changes`**.

*(N'oublie pas de faire ton dernier Commit + Push dans Iceberg pour sauvegarder ton code Pharo !)*
