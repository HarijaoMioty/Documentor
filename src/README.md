# Documentor

Un outil d'analyse de code pour Pharo qui génère un rapport au format Microdown sur une classe donnée.

## Installation

Pour installer ce projet dans votre image Pharo, exécutez l'expression Metacello suivante dans un Playground :

```smalltalk
Metacello new
    baseline: 'Documentor';
    repository: 'github://HarijaoMioty/Documentor/src';
    load.
