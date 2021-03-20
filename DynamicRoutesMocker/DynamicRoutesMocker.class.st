Class {
	#name : #DynamicRoutesMocker,
	#superclass : #Object,
	#instVars : [
		'teapot'
	],
	#category : #DynamicRoutesMocker
}

{ #category : #initialization }
DynamicRoutesMocker class >> activateOn: aTeapot [ 
	^self new initializedWithTeapot: aTeapot .
]

{ #category : #initialization }
DynamicRoutesMocker >> initializedWithTeapot: aTeapot [ 
	teapot := aTeapot .
	self publishRegisterRoute.
	self publishRemoveRoute.
	^ self.
]

{ #category : #initialization }
DynamicRoutesMocker >> publishRegisterRoute [

	teapot POST: '/register' -> [ :req | 
			self registerGETRequest: (req at: #pattern) thatShouldRespond: (req at: #response).
			'ok, good'.
		].
]

{ #category : #initialization }
DynamicRoutesMocker >> publishRemoveRoute [

	teapot POST: '/remove' -> [ :req | 
			self removeRoutesWithPattern: (req at: #pattern) andMethod: #GET.
			'sure, done'.
		].
]

{ #category : #register }
DynamicRoutesMocker >> registerGETRequest: aPattern thatShouldRespond: aResponse [ 
	teapot GET: aPattern -> [ :req | aResponse ].
]

{ #category : #unregister }
DynamicRoutesMocker >> removeRoutesWithPattern: aPattern andMethod: aMethod [ 
	teapot removeDynamicRoutesSuchThat: [:aRoute |
		aRoute canHandleEndpoint: aPattern andMethod: aMethod. 
	].
]
