Class {
	#name : 'DocumentorVisitor',
	#superclass : 'OCProgramNodeVisitor',
	#instVars : [
		'usesInstanceVariable',
		'usesSelf'
	],
	#category : 'Documentor-Core',
	#package : 'Documentor-Core'
}

{ #category : 'initialization' }
DocumentorVisitor >> initialize [
    super initialize.
    usesInstanceVariable := false.
    usesSelf := false
]

{ #category : 'accessing' }
DocumentorVisitor >> usesInstanceVariable [
    ^ usesInstanceVariable
]

{ #category : 'accessing' }
DocumentorVisitor >> usesSelf [
    ^ usesSelf
]

{ #category : 'visiting' }
DocumentorVisitor >> visitSelfNode: aNode [
    usesSelf := true.
    ^ super visitSelfNode: aNode
]

{ #category : 'visiting' }
DocumentorVisitor >> visitVariableNode: aNode [
    aNode isInstanceVariable ifTrue: [ usesInstanceVariable := true ].
    ^ super visitVariableNode: aNode
]
