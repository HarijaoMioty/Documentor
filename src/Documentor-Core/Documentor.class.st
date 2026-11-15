Class {
	#name : 'Documentor',
	#superclass : 'Object',
	#instVars : [
		'targetClass'
	],
	#category : 'Documentor-Core',
	#package : 'Documentor-Core'
}

{ #category : 'instance creation' }
Documentor class >> on: aClass [
    ^ self new
        targetClass: aClass;
        yourself
]

{ #category : 'reporting' }
Documentor >> report [
    | builder |
    builder := MicMicrodownTextualBuilder new.
    
    "Titre avec le nom de la classe (contournement)"
    builder text: '# ', targetClass name.
    builder newLine.
    
    "Héritage"
    builder text: '- a subclass of ', targetClass superclass name.
    builder newLine.
    
    "Champs (variables d'instance)"
    builder text: '- has the following fields: '.
    targetClass instVarNames do: [ :each | builder text: '#', each, ' ' ].
    builder newLine.
    
    "Package"
    builder text: '- is defined in package ', targetClass package name.
    
    ^ builder contents
]

{ #category : 'accessing' }
Documentor >> targetClass: aClass [
    targetClass := aClass
]
