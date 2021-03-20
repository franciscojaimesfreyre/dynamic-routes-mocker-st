Class {
	#name : #DynamicRoutesMockerTest,
	#superclass : #TestCase,
	#category : #'DynamicRoutesMocker-Tests'
}

{ #category : #tests }
DynamicRoutesMockerTest >> defaultTestClass [

	^TLRESTApiURLPathBuilder
]

{ #category : #tests }
DynamicRoutesMockerTest >> initTeapot [

	^Teapot configure: {
		#port -> 8888
 	}
]

{ #category : #tests }
DynamicRoutesMockerTest >> setUp [
	"Setup the test"
	super setUp.
]

{ #category : #tests }
DynamicRoutesMockerTest >> tearDown [
	
	super tearDown
]

{ #category : #tests }
DynamicRoutesMockerTest >> testCanPublishRegisterEndpointWhenInitialized [
	|teapot actualResponse|
	
	teapot := self initTeapot.
	DynamicRoutesMocker activateOn: teapot.
	teapot start.
	actualResponse := ZnEasy post: 'http://localhost:8888/register' data:  (ZnEntity text: 'data').
	self deny: actualResponse isNotFound.
	teapot stop.
	
]

{ #category : #tests }
DynamicRoutesMockerTest >> testCanPublishRemoveEndpointWhenInitialized [
	|teapot actualResponse|
	
	teapot := self initTeapot.
	DynamicRoutesMocker activateOn: teapot.
	teapot start.
	actualResponse := ZnEasy post: 'http://localhost:8888/remove' data:  (ZnEntity text: 'data').
	self deny: actualResponse isNotFound.
	teapot stop.
	
]

{ #category : #tests }
DynamicRoutesMockerTest >> testCanRegisterANewRouteSuccessfully [
	|teapot routeRegister aResponse actualResponse|
	
	teapot := self initTeapot.
	routeRegister := DynamicRoutesMocker activateOn: teapot.
	aResponse := 'ok'.
	routeRegister registerGETRequest: '/test' thatShouldRespond: aResponse. 
	
	teapot start.
	actualResponse := ZnEasy get:'http://localhost:8888/test'.
	self assert: actualResponse isSuccess.
	self assert: actualResponse contents equals: 'ok'.
	teapot stop.
	
]

{ #category : #tests }
DynamicRoutesMockerTest >> testCanRemoveANewRouteSuccessfully [
	|teapot routeRegister aResponse actualResponse|
	
	teapot := self initTeapot.
	routeRegister := DynamicRoutesMocker activateOn: teapot.
	aResponse := 'ok'.
	routeRegister registerGETRequest: '/test' thatShouldRespond: aResponse. 
	routeRegister removeRoutesWithPattern: '/test' andMethod: #GET.
	teapot start.
	actualResponse := ZnEasy get:'http://localhost:8888/test'.
	self assert: actualResponse isNotFound.
	teapot stop.
	
]

{ #category : #tests }
DynamicRoutesMockerTest >> testIfRouteIsNotRemovedStatusIsNot404NotFound [
	|teapot routeRegister aResponse actualResponse|
	
	teapot := self initTeapot.
	routeRegister := DynamicRoutesMocker activateOn: teapot.
	aResponse := 'ok'.
	routeRegister registerGETRequest: '/test' thatShouldRespond: aResponse. 
	teapot start.
	actualResponse := ZnEasy get:'http://localhost:8888/test'.
	self deny: actualResponse isNotFound.
	teapot stop.
	
]
