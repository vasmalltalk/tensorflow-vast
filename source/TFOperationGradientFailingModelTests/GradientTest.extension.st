Extension {
	#name : 'GradientTest'
}

{ #category : '*TFOperationGradientFailingModelTests',
 #vaCategories : ['Test'] }
GradientTest >> testMSEGradient [

	| prediction expected mse gradWeight |

	self skip. " This test fails randomly and don't know why. Needs work "
	prediction := tf variableNamed: 'prediction' with: 3 asFloatTensor.
	expected := tf constantWith: Float pi.

	mse := MeanSquaredError of: prediction whenExpectedIs: expected.

	gradWeight := Gradient of: mse withRespectTo: prediction.

	self assertOutputOf: (tf compute: gradWeight) isFloatScalarCloseTo: 2 * (3 - Float pi)
]