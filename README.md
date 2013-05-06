# SIAD\com.isel.siad.sv1213.bit

## Requirements[PT]:
1. SQL Server Business Intelligence Development Studio 9 (2008) instalado e funcional.
2. Acesso à Internet
3. Acesso à VPN "homer.refertelecom.pt". 

## Configuration Notes[PT]:
Antes de abrir a solucao com.isel.siad.sv1213.bit.sln, efectuar as seguintes configuracoes:
Considerando que (local repositories) é o caminho para a pasta onde se encontra a pasta de repositorio local "com.isel.siad.sv1213.bit". No ficheiro:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\BitMainPackage.Variables.dtsConfig
	
Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::FinacialPackagePath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx

Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::SQLETLPath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\#SQL\ETL\</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\#SQL\ETL\	

Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::OperationalPackagePath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\OperationalPackage.dtsx</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\#SQL\ETL\	

No ficheiro:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\BitMainPackage.Connections.dtsConfig

Substituir Connection String:
	
	Data Source=10.137.41.4\SQLEXPRESS;User ID=siad_bit_dev; Password=siad_bit_dev;Provider=SQLNCLI10.1;Persist Security Info=True;

Pela Connection String desejada que aponta para o servidor onde ficará a base de dados de DataStaging.

Nos ficheiros:

	(path)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\OperationalPackage.Connections.dtsConfig
	(path)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinancialPackage.Connections.dtsConfig

Substituir Connection String:

	Data Source=10.137.41.4\SQLEXPRESS;User ID=siad_bit_dev; Password=siad_bit_dev;Initial Catalog=DataStagingBIT;Provider=SQLNCLI10.1;Persist Security Info=True;
	
Pela Connection String que aponta para o servidor onde se encontra a base de dados de DataStaging.
	
Ao abrir solução "com.isel.siad.sv1213.bit.sln" e durante a utilização, se for pedida alguma password colocar "siad_bit_dev" (sem aspas).

Executar pacote BitMainPackage.dtsx (este pacote chamará os outros pacotes).