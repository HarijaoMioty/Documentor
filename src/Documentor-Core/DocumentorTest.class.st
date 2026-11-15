Class {
	#name : 'DocumentorTest',
	#superclass : 'TestCase',
	#category : 'Documentor-Core',
	#package : 'Documentor-Core'
}

{ #category : 'tests' }
DocumentorTest >> testReportGeneration [
    | documentor report |
    "On crée un documentor sur une classe connue"
    documentor := Documentor on: OrderedCollection.
    report := documentor report.
    
    "On vérifie que le rapport contient bien le nom de la classe"
    self assert: (report includesSubstring: 'OrderedCollection').
    
    "On vérifie qu'il contient la section des méthodes"
    self assert: (report includesSubstring: '## Methods').
]
