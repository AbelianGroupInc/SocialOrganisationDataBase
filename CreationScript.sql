﻿/* Table Leader, (ID, FIO, E-MAIL)*/
CREATE TABLE	Leader
	(Id INTEGER NOT NULL PRIMARY KEY,
	FIO Char(40) NOT NULL,
	Email Char(70) NOT NULL); /* Need to realise the constrain ...@...*/


/* Table Organisation, (ID, Full_Name, Cutet_Name, Creation_date, Sertificate_Date,
Initiative_Group_Description, Type, LeaderID)*/
CREATE TABLE	Organisation
	(Id INTEGER NOT NULL PRIMARY KEY,
	FullName CHAR(100) NOT NULL UNIQUE,
	CutetName CHAR(50) NOT NULL UNIQUE,
	CreationDate DATE,
	SertificateDate DATE,
	InitiativeGroupDescription TEXT,
	/*Atribute Type - how to describe this*/
	LeaderId INTEGER NOT NULL,
	FOREIGN KEY(LeaderId) REFERENCES Leader(Id));

/* Table Legalisation, (ID, Registration_Date, Reference__To_The_Site, Number_Of_Registration, Legalisation_Or_Registration,
Number_Of_Order, Sertificate_Number)*/
CREATE TABLE	Legalisation
	(Id BIGINT NOT NULL PRIMARY KEY,
	RegistrationDate DATE NOT NULL, 
	ReferenceToTheSite CHAR(100) NOT NULL,
	NumberOfRegistration INTEGER NOT NULL,
	LegalisationOrRegistration CHAR (254) NOT NULL, /*Not sure about the type*/
	NumberOfOrder INTEGER 	NOT NULL,
	SertificateNumber INTEGER NOT NULL,
	FOREIGN KEY(Id) REFERENCES Organisation(Id));

/* Table ConctactInformation, (ID, Email, Website_Address, Fax, Legal_Address)*/
CREATE TABLE	ContactInformation
	(Id INTEGER NOT NULL PRIMARY KEY,
	Email CHAR(70), /* Need to realise the constrain ...@...*/
	WebsiteAddress CHAR(254),
	Fax INTEGER,
	FOREIGN KEY(Id) REFERENCES Organisation(Id));

/* Table OrganisationDescription, (ID, Organisation_Info, Charter, Purposes_Description)*/	
CREATE TABLE	OrganisationDescription
	(Id INTEGER NOT NULL PRIMARY KEY,
	OrganisationInfo TEXT NOT NULL,
	Charter TEXT NOT NULL,
	PurposesDescription TEXT NOT NULL,
	ActivityDirection TEXT,
	Profitale BOOLEAN,
	FOREIGN KEY(Id) REFERENCES Organisation(Id));

/*Table PhoneNumber, (Id, PHONE_NAME, PHONE_VALUE, IS_FAX, IS_MOBILE)*/
CREATE TABLE	PhoneNumber
	(Id INTEGER NOT NULL PRIMARY KEY,
	PhoneName CHAR(50),
	PhoneValue INTEGER NOT NULL,
	IsFax BOOLEAN,
	IsMobile BOOLEAN);

/* Table LeaderContacts, (LEADER_ID, PHONE_ID)*/
CREATE TABLE	LeaderContacts
	(PhoneId INTEGER NOT NULL,
	LeaderId INTEGER NOT NULL,
	FOREIGN KEY(PhoneId) REFERENCES PhoneNumber(Id),
	FOREIGN KEY(LeaderId) REFERENCES Leader(Id),
	PRIMARY KEY(PhoneId, LeaderId));

/*Table ActualAddress, (ID, ADDRESS_NAME, ADDRESS_VALUE, PHONE_NUMBER_ID)*/
CREATE TABLE	ActualAddress
	(Id INTEGER NOT NULL PRIMARY KEY,
	AddressName CHAR(70),
	AddressValue INT);

/*Table TelefonOfAddress, (ADDRESS_ID, PHONE_ID)*/
CREATE TABLE	TelefonOfAddress
	(AddressId INTEGER NOT NULL,
	PhoneId	INTEGER	NOT NULL,
	PRIMARY KEY(AddressId, PhoneId),
	FOREIGN KEY(AddressId) REFERENCES ActualAddress(Id),
	FOREIGN KEY(PhoneId) REFERENCES PhoneNumber(Id));

/*Table NoteInAddressbook, (ContactInfoId, AddressId)*/
CREATE TABLE	NoteInAddressbook
	(ContactInfoId INTEGER NOT NULL,
	AddressId INTEGER NOT NULL,
	PRIMARY KEY(ContactInfoId, AddressId),
	FOREIGN KEY(ContactInfoId) REFERENCES ContactInformation(Id),
	FOREIGN KEY(AddressId) REFERENCES ActualAddress(Id));

/* Table NoteInPhonebook, (ContactInfoId, PhoneId)*/
CREATE TABLE	NoteInPhonebook
	(ContactInfoId INTEGER NOT NULL,
	PhoneId INTEGER NOT NULL,
	PRIMARY KEY(ContactInfoId, PhoneId),
	FOREIGN KEY(ContactInfoId) REFERENCES ContactInformation(Id),
	FOREIGN KEY(PhoneId) REFERENCES PhoneNumber(Id));

/*Table Cooperative, (Organisation1Id, Organisation2Id)*/
CREATE TABLE Cooperative
	(Organisation1Id INT NOT NULL,
	Organisation2Id INT NOT NULL,
	Description TEXT,
	PRIMARY KEY (Organisation1Id, Organisation2Id),
	FOREIGN KEY(Organisation1Id) REFERENCES Organisation(Id),
	FOREIGN KEY(Organisation2Id) REFERENCES Organisation(Id));
	
/*Table ActivityDirectory, (OrganisationId, AtivityId)*/
CREATE TABLE ActivityDirectory
	(OrganisationId INT NOT NULL,
	ActivityId INT NOT NULL,
	PRIMARY KEY(OrganisationId, ActivityId),
	FOREIGN KEY(OrganisationId) REFERENCES Organisation(Id),
	FOREIGN KEY(ActivityId) REFERENCES Organisation(Id));

/*Table Activity, (Id, ActivityName, Type, NumberOfMembers, PurposeDescription,
Result)*/
CREATE TABLE Activity
	(Id INT NOT NULL PRIMARY KEY,
	ActivityName CHAR(100) NOT NULL UNIQUE,
	/*Relisation of Type*/
	NumberOfMembers INT,
	PurposeDescription TEXT,
	Result TEXT);

/*Table ActivityProperties, (Id, Openness, Audience, County, Level, Frequene,
FundingType, Funded, PoliticalComposeExistance)*/
CREATE TABLE ActivityProperties
	(Id INT NOT NULL PRIMARY KEY,
	Openness CHAR(5) 
		CHECK (Openness IN('Open','Close')),
	Audience CHAR(7)
		CHECK (Audience IN('Mass', 'Address')),
	Country CHAR(9)
		CHECK (Country IN('Ukrainian','Foreign')),
	Level CHAR(12)
		CHECK (Level IN('Proffesional', 'Amatour')),
	Frequence CHAR(6)
		CHECK (Frequence IN('Single', 'Mass')),
	FundingType CHAR(9)
		CHECK (FundingType IN('Funding','Volunteer')),
	Funded CHAR(15)
		CHECK (Funded IN('OwnResources','ExternalFunding')),
	/*Need to implement ExternalFunding types*/

	PoliticalComposeExistance BOOLEAN,	
	FOREIGN KEY(Id) REFERENCES Activity(Id));

/*Table EProgram, (Id, Duration, PergormingSteps, OrganisatorsId,
LeaderId, PurposeDescription)*/
CREATE TABLE AProgram
	(Duration DATE,
	PerformingSteps TEXT,
	OrganisatorsId INT NOT NULL,
	LeaderId INT NOT NULL,
	FOREIGN KEY(OrganisatorsId) REFERENCES Organisation(Id),
	FOREIGN KEY(LeaderId) REFERENCES Leader(Id))
	INHERITS (Activity);

/*Table Events, (Id, Edate)*/
CREATE TABLE AEvent
	(EDate DATE NOT NULL)
	INHERITS (Activity);

/*Table SocialNetworkAddress,  (Id, AddressName, AddressValue, CotactIndoId)*/
CREATE TABLE SocialNetworkAddress
	(Id INT NOT NULL PRIMARY KEY,
	AddressName CHAR(100),
	AddressValue INT NOT NULL,
	ContactInfoId INT NOT NULL,
	FOREIGN KEY(ContactInfoId) REFERENCES ContactInformation(Id));
