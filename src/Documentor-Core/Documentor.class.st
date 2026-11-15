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
    
    "7. Méthodes et commentaires"
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
