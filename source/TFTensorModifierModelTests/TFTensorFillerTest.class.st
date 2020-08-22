Class {
	#name : 'TFTensorFillerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFTensorModifierModelTests'
}

{ #category : 'Test' }
TFTensorFillerTest >> testFillConstant [

	| const1 const2 |

	const1 := TFFiller on: tf fillWith: 4 tensorShaped: #(2 4) andType: TFTensor typeFloat.
	const2 :=
		TFFiller fillWith: 1.0 tensorShaped: (TFConstant on: tf with: #(3 2) asInt32Tensor).

	self assertOutputOf: const1 isMatrixCloseTo: #((4 4 4 4) (4 4 4 4)).
	self assertOutputOf: const2 isMatrixCloseTo: #((1 1) (1 1) (1 1))
]