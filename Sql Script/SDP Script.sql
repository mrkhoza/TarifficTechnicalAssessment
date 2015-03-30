USE LegalAidSAClinics
GO/*
CREATE TABLE dbo.PractitionersInfo
(
	PartyID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	PractitionerName VARCHAR(60) NULL,
	JC VARCHAR(50) NULL,
	DateCreated DATETIME NULL DEFAULT GETDATE(),
	CreatedBy VARCHAR(50) NULL,
	LastModDate DATETIME NULL,
	LastModUser VARCHAR(50) NULL,
	ReportingMonth VARCHAR(10) NULL
)

CREATE TABLE dbo.PractitionersWorkDays
(
	FKPartyID UNIQUEIDENTIFIER NOT NULL,
	Activity VARCHAR(50) NOT NULL,
	CourtName VARCHAR(50) NULL DEFAULT NULL,
	CourtType VARCHAR(50) NULL DEFAULT NULL,
	CourtRoom VARCHAR(30) NULL DEFAULT NULL,
	LeaveType VARCHAR(50) NULL DEFAULT NULL,
	DateCreated DATETIME NULL DEFAULT GETDATE(),
	CreatedBy VARCHAR(50) NULL ,
	LastModDate DATETIME NULL,
	[WeekDay] VARCHAR(50) NULL,
	LastModUser VARCHAR(50) NULL,
	ReportingMonth VARCHAR(10) NULL,
	FOREIGN KEY(FKPartyID)REFERENCES PractitionersInfo (PartyID) 
	ON DELETE CASCADE
	ON UPDATE CASCADE
)





Declare @Count AS INTEGER

EXEC  @Count = dbo.usp_SaveProctitionerInfo '589ADC76-7EDC-4464-A382-221F4EE25933','Daren  Rogers Sampson','Orlando','District/Magistrates','B','Soweto','Feb 2015','Tester','3 Feb 2015'

Select  @Count 

Select FKPartyID,[WeekDay] From dbo.PractitionersWorkDays Where FKPartyID = '589ADC76-7EDC-4464-A382-221F4EE25933' And [WeekDay] = '3 Feb 2015'

Select * From  dbo.PractitionersWorkDays
Select * From  dbo.PractitionersInfo
   
   
*/


ALTER PROC dbo.usp_SaveProctitionerInfo

	@PartyID As UNIQUEIDENTIFIER,
	@Activity AS VARCHAR(50), 
	@PractitionerName AS VARCHAR(60),
	@CourtName AS VARCHAR(50) = NULL,
	@CourtType AS VARCHAR(50) = NULL,
	@CourtRoom AS VARCHAR(30) = NULL,
	@LeaveType AS VARCHAR(50) = NULL,
	@JC As VARCHAR(50),
	@ReportingMonth AS VARCHAR(10),
	@CreatedBy AS VARCHAR(50),
	@WeekDay AS VARCHAR(50)
	
AS
BEGIN
		IF NOT EXISTS(Select FKPartyID From dbo.PractitionersWorkDays Where FKPartyID = @PartyID)
		BEGIN
			INSERT INTO dbo.PractitionersInfo(PartyID,PractitionerName,JC,ReportingMonth,CreatedBy)
			VALUES(@PartyID,@PractitionerName,@JC,@ReportingMonth,@CreatedBy)
			
			INSERT INTO dbo.PractitionersWorkDays(FKPartyID,Activity,CourtName,CourtType,CourtRoom,LeaveType,ReportingMonth,CreatedBy,[WeekDay])
			VALUES(@PartyID,@Activity,@CourtName,@CourtType,@CourtRoom,@LeaveType,@ReportingMonth,@CreatedBy,@WeekDay)
		END
		ELSE IF EXISTS(Select FKPartyID From dbo.PractitionersWorkDays Where FKPartyID = @PartyID And [WeekDay] = @WeekDay)
		BEGIN
			SELECT 'Duplicate' As [Duplicate]
		END
		ELSE
		BEGIN
			INSERT INTO dbo.PractitionersWorkDays(FKPartyID,Activity,CourtName,CourtType,CourtRoom,LeaveType,ReportingMonth,CreatedBy,[WeekDay])
			VALUES(@PartyID,@Activity,@CourtName,@CourtType,@CourtRoom,@LeaveType,@ReportingMonth,@CreatedBy,@WeekDay)
		END
	END

