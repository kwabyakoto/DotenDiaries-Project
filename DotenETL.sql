CREATE TABLE tblBIBLIOGRAPHY (
	BibliographyID int PRIMARY KEY,
	AuthorName varchar (30),
	PublicationTitle varchar (50),
	ArticleTitle varchar (50),
	WherePublished varchar (50),
	PublicationCompany varchar (50),
	VolumeNumber int,
	PageNumber int
);

CREATE TABLE tblANNOTATION (
	AnnotationID int PRIMARY KEY,
	Term Varchar (255),
	Annotation TEXT,
	BibliographyID int References tblBIBLIOGRAPHY(BibiographyID));

CREATE TABLE tblTRANSCRIBER (
	TranscriberID int PRIMARY KEY,
	FirstName varchar(30) not null;
	LastName varchar(30) not null;
	Email varchar(30);
	PhoneNumber char(15) not null
);

CREATE TABLE tblBOOK (
	BookID int PRIMARY KEY,
	BookNum int,
	TranscriberID int References tblTRANSCRIBER(TranscriberID));

CREATE TABLE tblPAGE (
	PageID int PRIMARY KEY,
	Image VarBinary(max),
	BookID int References tblBOOK(BookID));

CREATE TABLE tblENTRY (
	EntryID int PRIMARY KEY,
	BookPageNum int,
	EntryDate datetime,
	TranscriptionDate datetime,
	PageID int References tblPAGE(PageID));


CREATE TABLE tblTag (
	TagID int PRIMARY KEY,
	Type char (15)
);

CREATE TABLE tblEntryTag (
	EntryTagID int PRIMARY KEY,
	Text TEXT,
	EntryID int References tblEntry(EntryID));
	TagID int References tblTag(TagID));



CREATE TABLE tblEntryAnnotation (
	EntryID int References tblEntry(EntryID),
	AnnotationID int Reference tblAnnotation(AnnotationID),
	Primary Key (EntryID, AnnotationID));
 
	
	

	
