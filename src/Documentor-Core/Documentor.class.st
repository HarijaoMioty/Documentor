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
    | builder superMethodsCount |
    builder := MicMicrodownTextualBuilder new.
    
    "1. Titre"
    builder text: '# ', targetClass name.
    builder newLine.
    
    "2. Premier paragraphe du commentaire"
    targetClass comment ifNotNil: [ :c |
        | firstParagraph |
        firstParagraph := c asString splitOn: String cr, String cr.
        firstParagraph ifNotEmpty: [ 
            builder text: firstParagraph first.
            builder newLine.
        ].
    ].
    
    "3. Héritage"
    builder text: '- a subclass of ', targetClass superclass name.
    builder newLine.
    
    "4. Position dans la hiérarchie (superclasses)"
    builder text: '**Hierarchy:** '.
    targetClass allSuperclasses do: [ :superclass |
        builder text: superclass name, ' > '.
    ].
    builder newLine.
    
    "5. Champs"
    builder text: '- has the following fields: '.
    targetClass instVarNames do: [ :each | builder text: '#', each, ' ' ].
    builder newLine.
    
    "6. Package"
    builder text: '- is defined in package ', targetClass package name.
    builder newLine.
    
    "7. METRIQUES"
    builder text: '## Metrics'.
    builder newLine.
    
    "Profondeur d'héritage"
    builder text: '- Inheritance depth: ', targetClass allSuperclasses size printString.
    builder newLine.
    
    "Champs hérités"
    builder text: '- Inherited fields: ', (targetClass allInstVarNames size - targetClass instVarNames size) printString.
    builder newLine.
    
    "Champs définis"
    builder text: '- Defined fields: ', targetClass instVarNames size printString.
    builder newLine.
    
    "Méthodes héritées"
    builder text: '- Inherited methods: ', (targetClass allMethods size - targetClass methods size) printString.
    builder newLine.
    
    "Méthodes définies"
    builder text: '- Defined methods: ', targetClass methods size printString.
    builder newLine.
    
    "Méthodes qui appellent super (Recherche simple dans le code source)"
    superMethodsCount := 0.
    targetClass methods do: [ :m | 
        (m sourceCode includesSubstring: 'super') ifTrue: [ superMethodsCount := superMethodsCount + 1 ].
    ].
    builder text: '- Methods calling super: ', superMethodsCount printString.
    builder newLine.
    
    "Noms de méthodes trop longs (ex: > 20 caractères)"
    builder text: '- Methods with overly long names: '.
    (targetClass methods select: [ :m | m selector size > 20 ]) 
        do: [ :m | builder text: m selector, ' ' ].
    builder newLine.
    
    "8. Méthodes et commentaires"
    builder text: '## Methods'.
    builder newLine.
    targetClass methods do: [ :method |
        builder text: '- `', method selector, '`'.
        method comment ifNotNil: [ :comment |
            | firstLine |
            firstLine := comment asString lines first.
            builder text: ': ', firstLine.
        ].
        builder newLine.
    ].
    
    ^ builder contents
]

{ #category : 'accessing' }
Documentor >> targetClass: aClass [
    targetClass := aClass
]
