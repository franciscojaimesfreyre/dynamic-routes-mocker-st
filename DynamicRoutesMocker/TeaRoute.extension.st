Extension { #name : #TeaRoute }

{ #category : #'*DynamicRoutesMocker' }
TeaRoute >> canHandleEndpoint: anEndpoint andMethod: aMethod [
	
	^ self canHandleRequest: 
	  (ZnRequest method: aMethod url: ('http://thisCouldBeAnything:', port asString, anEndpoint) asZnUrl). 
]

{ #category : #'*DynamicRoutesMocker' }
TeaRoute >> canHandleRequest: aZnRequest [ 
	^requestMatcher matchRequest: aZnRequest ifMatch: [:b | ^true. ] ifNoMatch: [ ^false. ] . 
]
