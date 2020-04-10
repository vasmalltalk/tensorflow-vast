Class {
	#name : 'SizeMismatch',
	#superclass : 'Error',
	#category : 'PharoCompatibilityModel'
}

{ #category : 'Signaling' }
SizeMismatch class >> signal [


	^self signalWith: 'Collections sizes do not match'
]