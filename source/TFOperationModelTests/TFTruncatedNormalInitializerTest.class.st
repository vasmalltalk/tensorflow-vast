Class {
	#name : 'TFTruncatedNormalInitializerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFTruncatedNormalInitializerTest >> testUsingSeed [

	| initializer variable |

	initializer := TFTruncatedNormalInitializer withSeeds: #(0 1).
	variable := TFVariable
		on: tf
		named: 'input'
		forFloatsShaped: #(2 3)
		initializedWith: initializer.

	self
		assertOutputOf: variable
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: #(1.20643472671509 -1.88216388225555 1.24967527389526);
				add: #(-5.52506625652313e-1 -4.45415258407593e-1 3.9816003292799e-2);
				yourself)
]