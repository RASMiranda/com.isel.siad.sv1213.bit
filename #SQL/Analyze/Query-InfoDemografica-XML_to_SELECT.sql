SELECT
      c.value('(./BirthDate)[1]', 'nvarchar(max)') as BirthDate
      ,c.value('(./MaritalStatus)[1]', 'nvarchar(max)') as MaritalStatus
      ,c.value('(./YearlyIncome)[1]', 'nvarchar(max)') as YearlyIncome
      ,c.value('(./Gender)[1]', 'nvarchar(max)') as Gender
      ,c.value('(./TotalChildren)[1]', 'int') as TotalChildren
      ,c.value('(./NumberChildrenAtHome)[1]', 'int') as NumberChildrenAtHome
      ,c.value('(./Education)[1]', 'nvarchar(max)') as Education
      ,c.value('(./Occupation)[1]', 'nvarchar(max)') as Occupation
      ,c.value('(./HomeOwnerFlag)[1]', 'nvarchar(max)') as HomeOwnerFlag
      ,c.value('(./NumberCarsOwned)[1]', 'int') as NumberCarsOwned
FROM (SELECT infoDemografica as col FROM InfoDemografica) as tbl
	CROSS APPLY col.nodes('/IndividualSurvey') t(c)
GO
