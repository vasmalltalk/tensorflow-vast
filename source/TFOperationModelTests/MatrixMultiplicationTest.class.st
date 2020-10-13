Class {
	#name : 'MatrixMultiplicationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
MatrixMultiplicationTest >> testMultiplyMatrixAndVector [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2) (2.1 2.2)) named: 'a'.
	constB := tf floatConstantWith: #((2.0) (8.0)) named: 'b'.

	output := constA dot: constB.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
			OrderedCollection new
				add: 1.1 * 2.0 + (1.2 * 8.0);
				add: 2.1 * 2.0 + (2.2 * 8.0);
				asArray)
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationMatMul [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2) (2.1 2.2)) named: 'a'.
	constB := tf floatConstantWith: #((2.0 4.0) (8.0 16.0)) named: 'b'.

	output := constA dot: constB.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1.1 * 2.0 + (1.2 * 8.0) with: 1.1 * 4.0 + (1.2 * 16.0));
				add: (Array with: 2.1 * 2.0 + (2.2 * 8.0) with: 2.1 * 4.0 + (2.2 * 16.0));
				yourself)
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationMatMul1x1 [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1)) named: 'a'.
	constB := tf floatConstantWith: #((3.14)) named: 'b'.

	output := constA dot: constB.

	self assertOutputOf: output isMatrixCloseTo: (Array with: 1.1 * 3.14).

	self deny: output isFirstOperatorTransposed.
	self deny: output isSecondOperatorTransposed
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationMatMul2x2 [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2) (2.1 2.2)) named: 'a'.
	constB := tf floatConstantWith: #((2.0 4.0) (8.0 16.0)) named: 'b'.

	output := constA dot: constB.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1.1 * 2.0 + (1.2 * 8.0) with: 1.1 * 4.0 + (1.2 * 16.0));
				add: (Array with: 2.1 * 2.0 + (2.2 * 8.0) with: 2.1 * 4.0 + (2.2 * 16.0));
				yourself).

	self deny: output isFirstOperatorTransposed.
	self deny: output isSecondOperatorTransposed
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationMatMulABTransposed [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2) (2.1 2.2)) named: 'a'.
	constB := tf floatConstantWith: #((2.0 4.0) (8.0 16.0)) named: 'b'.

	output := constA transposedDotTransposing: constB.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1.1 * 2.0 + (2.1 * 4.0) with: 1.1 * 8.0 + (2.1 * 16.0));
				add: (Array with: 1.2 * 2.0 + (2.2 * 4.0) with: 1.2 * 8.0 + (2.2 * 16.0));
				yourself).

	self assert: output isFirstOperatorTransposed.
	self assert: output isSecondOperatorTransposed
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationMatMulATransposed [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2) (2.1 2.2)) named: 'a'.
	constB := tf floatConstantWith: #((2.0 4.0) (8.0 16.0)) named: 'b'.

	output := constA transposedDot: constB.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1.1 * 2.0 + (2.1 * 8.0) with: 1.1 * 4.0 + (2.1 * 16.0));
				add: (Array with: 1.2 * 2.0 + (2.2 * 8.0) with: 1.2 * 4.0 + (2.2 * 16.0));
				yourself).

	self assert: output isFirstOperatorTransposed.
	self deny: output isSecondOperatorTransposed
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationMatMulBTransposed [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2) (2.1 2.2)) named: 'a'.
	constB := tf floatConstantWith: #((2.0 4.0) (8.0 16.0)) named: 'b'.

	output := constA dotTransposing: constB.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1.1 * 2.0 + (1.2 * 4.0) with: 1.1 * 8.0 + (1.2 * 16.0));
				add: (Array with: 2.1 * 2.0 + (2.2 * 4.0) with: 2.1 * 8.0 + (2.2 * 16.0));
				yourself).

	self deny: output isFirstOperatorTransposed.
	self assert: output isSecondOperatorTransposed
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testOperationName [

	| constA constB |

	constA := tf floatConstantWith: #((1.1)) named: 'a'.
	constB := tf floatConstantWith: #((3.14)) named: 'b'.

	self
		assert: (MatrixMultiplication of: constA and: constB) isNamedInGraphAs: 'MatMul';
		assert: (MatrixMultiplication of: constA and: constB) isNamedInGraphAs: 'MatMul_1';
		assert: (MatrixMultiplication named: 'output' of: constA and: constB)
			isNamedInGraphAs: 'output';
		assert: (MatrixMultiplication named: 'output' of: constA and: constB)
			isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
MatrixMultiplicationTest >> testPrinting [

	| constA constB |

	constA := tf floatConstantWith: #((1.1)) named: 'a'.
	constB := tf floatConstantWith: #((3.14)) named: 'b'.

	self
		assert: (MatrixMultiplication of: constA and: constB) asString equals: '(a x b)';
		assert: (MatrixMultiplication ofTransposed: constA and: constB) asString
			equals: '(a^T x b)';
		assert: (MatrixMultiplication of: constA andTransposed: constB) asString
			equals: '(a x b^T)';
		assert: (MatrixMultiplication ofTransposed: constA andTransposed: constB) asString
			equals: '(a^T x b^T)'
]