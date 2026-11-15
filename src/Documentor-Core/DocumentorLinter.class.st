Class {
	#name : 'DocumentorLinter',
	#superclass : 'Object',
	#instVars : [
		'targetClass'
	],
	#category : 'Documentor-Core',
	#package : 'Documentor-Core'
}

{ #category : 'instance creation' }
DocumentorLinter class >> on: aClass [
    ^ self new
        targetClass: aClass;
        yourself
]

{ #category : 'reporting' }
DocumentorLinter >> report [
    | builder visitor noSelfMethods noInstVarMethods totalComplexity source complexity |
    builder := MicMicrodownTextualBuilder new.
    builder text: '## Linter Report'.
    builder newLine.
    
    noSelfMethods := OrderedCollection new.
    noInstVarMethods := OrderedCollection new.
    totalComplexity := 0.
    
    targetClass methods do: [ :method |
        visitor := DocumentorVisitor new.
        method ast acceptVisitor: visitor.
        
        "Règles du Linter"
        (visitor usesSelf not and: [ visitor usesInstanceVariable not ]) ifTrue: [
            noSelfMethods add: method selector.
        ].
        visitor usesInstanceVariable ifFalse: [
            noInstVarMethods add: method selector.
        ].
        
        "Calcul de la complexité cyclomatique"
        source := method sourceCode.
        complexity := (source occurrencesOf: 'ifTrue:') + 
                      (source occurrencesOf: 'ifFalse:') + 
                      (source occurrencesOf: 'ifNil:') +
                      (source occurrencesOf: 'whileTrue:') +
                      (source occurrencesOf: 'whileFalse:').
        totalComplexity := totalComplexity + complexity.
    ].
    
    "Génération du rapport"
    builder text: '### Methods not using self or instance variables:'.
    builder newLine.
    noSelfMethods do: [ :sel | builder text: '- ', sel; newLine ].
    builder newLine.
    
    builder text: '### Methods not using instance variables:'.
    builder newLine.
    noInstVarMethods do: [ :sel | builder text: '- ', sel; newLine ].
    builder newLine.
    
    builder text: '### Cyclomatic Complexity'.
    builder newLine.
    builder text: '- Total class complexity: ', totalComplexity printString.
    builder newLine.
    
    ^ builder contents
]

{ #category : 'accessing' }
DocumentorLinter >> targetClass: aClass [
    targetClass := aClass
]
