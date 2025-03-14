Class {
	#name : #GtkTableRowFiller,
	#superclass : #GtkTableColumnVisitor,
	#instVars : [
		'gtkRow',
		'row',
		'rowIndex'
	],
	#category : #'Mars-Spec-Adapter-Table'
}

{ #category : #private }
GtkTableRowFiller >> cacheAt: anObject ifAbsentPut: aBlock [ 
	| cache |
	
	"cache may not be set"
	cache := GtkTableRowFillerCache value.
	cache ifNil: [ ^ aBlock value ].
	
	^ cache 
		at: anObject 
		ifAbsentPut: aBlock
]

{ #category : #accessing }
GtkTableRowFiller >> gtkRow [
	^ gtkRow
]

{ #category : #accessing }
GtkTableRowFiller >> gtkRow: anObject [
	gtkRow := anObject
]

{ #category : #accessing }
GtkTableRowFiller >> row [
	^ row
]

{ #category : #accessing }
GtkTableRowFiller >> row: anObject [
	row := anObject
]

{ #category : #accessing }
GtkTableRowFiller >> rowIndex [
	^ rowIndex
]

{ #category : #accessing }
GtkTableRowFiller >> rowIndex: anObject [
	rowIndex := anObject
]

{ #category : #visiting }
GtkTableRowFiller >> visitCheckboxColumn: aTableColumn [

	self gtkRow
		at: (self columnIndexOf: aTableColumn)
		putBoolean: (aTableColumn readObject: self row)
]

{ #category : #visiting }
GtkTableRowFiller >> visitImageColumn: aTableColumn [
	| imageForm |

	self flag: #TODO. "I'm assuming the image is a Form, which may not be the case in the future"
	imageForm := aTableColumn readObject: self row.
	imageForm ifNil: [ ^ self ].
	
	self gtkRow
		at: (self columnIndexOf: aTableColumn) 
		putObject: (self 
			cacheAt: imageForm 
			ifAbsentPut: [ GdkPixbuf newForm: imageForm ])
]

{ #category : #visiting }
GtkTableRowFiller >> visitIndexColumn: aTableColumn [

	self gtkRow
		at: (self columnIndexOf: aTableColumn)
		putString: self rowIndex asString
]

{ #category : #visiting }
GtkTableRowFiller >> visitStringColumn: aTableColumn [

	self gtkRow
		at: (self columnIndexOf: aTableColumn)
		putString: (aTableColumn readObject: self row) asString
]
