# StateSpecs
[![Build Status](https://travis-ci.org/dionisiydk/StateSpecs.svg?branch=master)](https://travis-ci.org/dionisiydk/StateSpecs)

StateSpecs is object state specification framework. It describes particular object states by first class specifications. For example there are SpecOfCollectionItem, SpecOfObjectClass and SpecOfObjectSuperclass. 

To easily create specifications and validate objects by them StateSpecs provides two kind DSL: should expressions and "word" classes.

First allows you to write "assertions":
```Smalltalk
1 should be: 2
1 should equal: 10
```
And second allows you to instantiate specs by natural readable words:
```Smalltalk
Kind of: Number
Instance of: String
Equal to: 'test'
```
## Installation
Use following script for Pharo version >= 6:
```Smalltalk
Metacello new
  baseline: 'StateSpecs';
  repository: 'github://dionisiydk/StateSpecs';
  load
```
To add dependency in your project baseline:
```Smalltalk
spec
    baseline: 'StateSpecs'
    with: [ spec repository: 'github://dionisiydk/StateSpecs:v2.4.x' ]
```
For old Pharo versions project should be loaded from smalltalkhub:
```Smalltalk
Metacello new
      smalltalkhubUser: 'dionisiy' project: 'StateSpecs';
      configuration: 'StateSpecs';
      version: #stable;
      load.
```
## Other examples:   
```Smalltalk
1 should be: 2. "fail with message: Got '1' but it should be '2'"
1 should not be: 1. "fail with message: Got '1' but it should not be '1'"

3 should equal: 2. "fail with message: Got '3' but it should equal '2'"
3 should not equal: 3. "fail with message: Got '3' but it should equal '3'"

3 should beKindOf: String.
3 should not beKindOf: Number.

3 should beInstanceOf: Number.
3 should not beInstanceOf: SmallInteger.

#(1 2) should equal: #(10 20).
#(1 2) should equal: #(1 2) asOrderedCollection. "not fail because by default comparison not look at collection types"
#(1 2) should equal: #(1 2) asSet.
#(1 2) should equal: #(2 1). "not fail because by default equality between collections is not ordered"
#(1 2) should equalInOrder: #(2 1). "fail because it is explicit requirement for ordered equality"

#(1 2) should haveSize: 10.
#(1 2) should include: 10.
#(1 2) should include: (Kind of: String).
#(1 2) should include: [:number | number > 10]. 
#(1 2) should include: 10 at: 1.
#(1 2) should include: (Instance of: String) at: 1.
#(1 2) should include: (Kind of: String) at: 2.
#(1 2) should include: [:number | number > 10] at: 2.

'some test string' should includeSubstring: 'test2'
'some test string' should includeSubstring: 'Test' caseSensitive: true
'test string' should beginWith: 'test'
'test string' should beginWith: 'Test' caseSensitive: true
'string for test' should endWith: 'test2'
'string for test' should endWith: 'Test' caseSensitive: true
'test string' should matchRegex: '^test'
'test string' should matchRegex: '^Test' caseSensitive: true

[1 + 2] should raise: ZeroDivide.
[1/0] should not raise: ZeroDivide.
[1/0] should raise: Error.
[1/0] should raise: (Instance of: Error).
[1/0] should fail.
[self error: 'test'] should raise: errorInstance. "fail because raised error is not the same as expected errorInstance"
[1 + 2] should not fail.
error := [ self error: 'some error' ] should fail.
error should beInstanceOf: Error.
error where description should includeSubstring: 'some'

3 should be even.
2 should not be even.

3 should be between: 10 and: 50.
2 should not between: 1 and: 5.

#(1 2) should be isEmpty. "fail with message: #(1 2) should be isEmpty"
#() should not be isEmpty.

(1@3 corder: 20@30) where origin x should equal: 100. "fail with message: Got '1' from (1@3 corder: 20@30) origin x but it should equal: 100"
```

Look at all expressions in SpecOfShouldExpression class which you can extend with new keywords. SpecOfShouldExpressionTests describes them in tests.

Underhood should expression build concrete specification instance and validate subject of should expression by it. 

Specifications can be used to match and validate objects:
```Smalltalk
spec matches: anObject.
spec validate: anObject. "it returnes first class result (success or particular failure)"
```
Should expressions signal special SpecOfFailed exception by concrete validation failure. It makes possible to extend debugger tools to better analyse problem. Such tools can be specific for different kind of failures
