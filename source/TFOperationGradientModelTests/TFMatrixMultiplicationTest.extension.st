Extension {
	#name : 'TFMatrixMultiplicationTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFMatrixMultiplicationTest >> testGradientOfMatrixOutput [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2 1.3)) named: 'a'.
	constB := tf floatConstantWith: #((1.1) (2.1) (3.1)) named: 'b'.

	output := TFMatrixMultiplication of: constB and: constA.

	self
		assertPartialDerivativeOf: output
			withRespectTo: constA
			isMatrixCloseTo: (
				OrderedCollection new
					add: (
						Array with: (1.1 + 2.1 + 3.1) with: (1.1 + 2.1 + 3.1) with: (1.1 + 2.1 + 3.1));
					yourself);
		assertPartialDerivativeOf: output
			withRespectTo: constB
			isMatrixCloseTo: (
				OrderedCollection new
					add: (1.1 + 1.2 + 1.3);
					add: (1.1 + 1.2 + 1.3);
					add: (1.1 + 1.2 + 1.3);
					yourself)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFMatrixMultiplicationTest >> testGradientOfScalarOutput [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2 1.3)) named: 'a'.
	constB := tf floatConstantWith: #((1.1) (2.1) (3.1)) named: 'b'.

	output := TFMatrixMultiplication of: constA and: constB.

	self
		assertPartialDerivativeOf: output withRespectTo: constA isMatrixCloseTo: #((1.1 2.1 3.1));
		assertPartialDerivativeOf: output
			withRespectTo: constB
			isMatrixCloseTo: #((1.1) (1.2) (1.3))
]