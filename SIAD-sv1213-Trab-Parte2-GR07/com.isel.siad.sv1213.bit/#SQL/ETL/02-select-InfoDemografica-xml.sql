SELECT
      tbl.ClienteId
      ,c.value('(./BirthDate)[1]', 'datetime') as BirthDate
      ,c.value('(./MaritalStatus)[1]', 'varchar(150)') as MaritalStatus
      ,c.value('(./YearlyIncome)[1]', 'varchar(150)') as YearlyIncome
      ,c.value('(./Gender)[1]', 'varchar(150)') as Gender
      ,c.value('(./TotalChildren)[1]', 'varchar(150)') as TotalChildren
      ,c.value('(./NumberChildrenAtHome)[1]', 'varchar(150)') as NumberChildrenAtHome
      ,c.value('(./Education)[1]', 'varchar(150)') as Education
      ,c.value('(./Occupation)[1]', 'varchar(150)') as Occupation
      ,c.value('(./HomeOwnerFlag)[1]', 'varchar(150)') as HomeOwnerFlag
      ,c.value('(./NumberCarsOwned)[1]', 'varchar(150)') as NumberCarsOwned
      ,tbl.dataAlter
FROM (SELECT ClienteId, infoDemografica as col, dataAlter FROM [BIT].[dbo].[InfoDemografica]) as tbl
	CROSS APPLY col.nodes('/IndividualSurvey') t(c)