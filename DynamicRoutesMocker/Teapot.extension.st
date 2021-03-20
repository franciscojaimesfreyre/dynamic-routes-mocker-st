Extension { #name : #Teapot }

{ #category : #'*DynamicRoutesMocker' }
Teapot >> removeDynamicRoutesSuchThat: aBlock [

	dynamicRouter routes removeAllSuchThat: aBlock.
]
