Class {
	#name : 'CSVColumnDefinition',
	#superclass : 'Object',
	#instVars : [
		'definition'
	],
	#category : 'TFUtilityModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
CSVColumnDefinition class >> containing: aTensor [

	^self new initializeContaining: aTensor
]

{ #category : 'Instance Creation' }
CSVColumnDefinition class >> mandatoryTyped: aTensorType [

	^self containing: (TFTensor fromNumbers: #() type: aTensorType)
]

{ #category : 'Instance Creation' }
CSVColumnDefinition class >> nullableTyped: aTensorType defaultTo: aDefaultValue [

	^self containing: (TFTensor fromNumbers: (Array with: aDefaultValue) type: aTensorType)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CSVColumnDefinition >> initializeContaining: aTensor [

	definition := aTensor
]

{ #category : 'Converting' }
CSVColumnDefinition >> outputOn: aTensorFlowComputation [

	^(ConstantNode on: aTensorFlowComputation named: 'Const' with: definition) value firstOutput
]