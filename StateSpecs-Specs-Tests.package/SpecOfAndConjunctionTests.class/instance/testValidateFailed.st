tests
testValidateFailed
	| spec1 spec2 stateSpec result |
	spec1 := SpecOfEquality requiredValue: #expectedValue.
	spec2 := SpecOfObjectSuperclass requiredClass: String.
	
	stateSpec := SpecOfAndConjunction of: spec1 and: spec2.
	result := stateSpec validate: #wrongValue.
	
	self assert: result isFailure.
	self assert: result spec == spec1
