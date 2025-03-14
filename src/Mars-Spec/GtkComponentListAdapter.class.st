Class {
	#name : #GtkComponentListAdapter,
	#superclass : #GtkAdapter,
	#instVars : [
		'innerWidget'
	],
	#classInstVars : [
		'gtkWidget',
		'realWidget'
	],
	#category : #'Mars-Spec-Adapter'
}

{ #category : #specs }
GtkComponentListAdapter class >> adaptingAliases [

	^ #(FastTableAdapter)
]

{ #category : #building }
GtkComponentListAdapter >> addModelTo: gtkListBox [

	self presenter 
		property: #presenters
		whenChangedDo: [ :collection | 
			self updateWith: collection ].	
			
	self 
		update: gtkListBox 
		with: self presenter presenters
]

{ #category : #'private accessing' }
GtkComponentListAdapter >> innerWidget [

	^ widget child
]

{ #category : #testing }
GtkComponentListAdapter >> items [
	^ innerWidget items
]

{ #category : #building }
GtkComponentListAdapter >> update: gtkWidget with: aCollection [
	| listItem |
	
	gtkWidget removeAll.
	aCollection doWithIndex: [ :presenter :index | 
		listItem := presenter buildWithSpec asListBoxRow.
		gtkWidget add: listItem ].
	gtkWidget showAll
]

{ #category : #building }
GtkComponentListAdapter >> updateWith: aCollection [

	self 
		update: self innerWidget 
		with: aCollection
]

{ #category : #building }
GtkComponentListAdapter >> widgetClass [
	
	^ GtkListBox
]

{ #category : #building }
GtkComponentListAdapter >> wrapWidget: gtkWidget [

	innerWidget := gtkWidget.
	^ self wrapWithScrollableWindow: gtkWidget
		
]
