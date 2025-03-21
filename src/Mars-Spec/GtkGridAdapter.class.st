Class {
	#name : #GtkGridAdapter,
	#superclass : #GtkLayoutAdapter,
	#instVars : [
		'layout'
	],
	#category : #'Mars-Spec-Layout-Grid'
}

{ #category : #private }
GtkGridAdapter >> addConstraits: constraints toChild: childWidget [
	"adds constraits by child."
	
	(layout rowConstraintsAt: constraints position y) ifNotNil: [ :c |
		c expand ifNotNil: [ :expand | childWidget vExpand: expand ] ].
		
	(layout columnConstraintsAt: constraints position x) ifNotNil: [ :c |
		c expand ifNotNil: [ :expand | childWidget hExpand: expand ] ].
	
	constraints hAlign ifNotNil: [ :hAlign | childWidget hAlign: hAlign asGtkAlign ].
	constraints vAlign ifNotNil: [ :vAlign | childWidget vAlign: vAlign asGtkAlign ]
]

{ #category : #private }
GtkGridAdapter >> basicAdd: aPresenter constraints: constraints to: gtkWidget [
	| childWidget |

	childWidget := aPresenter buildWithSpec: constraints spec.
	childWidget data: aPresenter.
	self addConstraits: constraints toChild: childWidget.
	gtkWidget 
		attach: childWidget 
		at: constraints position 
		span: constraints span.
		
	^ gtkWidget
]

{ #category : #building }
GtkGridAdapter >> buildWidget [

	^ GtkGrid new
]

{ #category : #building }
GtkGridAdapter >> layout: aLayout [
	
	layout := aLayout.
	self widgetDo: [ :w |
		w 
			borderWidth: aLayout borderWidth;
			columnSpacing: aLayout columnSpacing;
			rowSpacing: aLayout rowSpacing;
			columnHomogeneous: aLayout isColumnHomogeneous;
			rowHomogeneous: aLayout isRowHomogeneous;
			show ]
]
