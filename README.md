# SIAD\com.isel.siad.sv1213.bit

## Requirements[PT]:
1. SQL Server Business Intelligence Development Studio 9 (2008) instalado e funcional.
2. Acesso à Internet

## Configuration Notes[PT]:
Antes de abrir a solucao com.isel.siad.sv1213.bit.sln, efectuar as seguintes configuracoes:

1) Correr batch RUNME.cmd (Run As Administrator)

2) Através da linha de comandos executar batch RUNMESQL.cmd passando como parâmetro a instância onde ficará o Data Wharehouse

4) Configurar os servidores alvos, e directorias locais nos ficheiros:
	\com.isel.siad.sv1213.bit.ssis\BitMainPackage.Connections.dtsConfig
	\com.isel.siad.sv1213.bit.ssis\BitMainPackage.Variables.dtsConfig
	\com.isel.siad.sv1213.bit.ssis\FinacialPackage.Connections.dtsConfig
	\com.isel.siad.sv1213.bit.ssis\FinacialPackage.Variables.dtsConfig
	\com.isel.siad.sv1213.bit.ssis\OperationalPackage.Connections.dtsConfig
	\#XMLA\02-create-com isel siad sv1213 bit ssas.xmla

	BIT será a conexão para a base de dados, no DW, onde se encontra os dados do OLTP sobre a qual correrá o ETL
	BITDW será a conexão para o servidor sql, DW, onde se encontra a base de dados de Data Staginng
	BITDW.DataStaging/Data Staging BIT será a conexão para a base de dados, DW, de Data Staging
	FinacialPackagePath: caminho completo para o ficheiro \com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx
	OperationalPackagePath: caminho completo para o ficheiro \com.isel.siad.sv1213.bit.ssis\OperationalPackage.dtsx

5) Executar o script \#XMLA\02-create-com isel siad sv1213 bit ssas.xmla sobre o Analisys Services do DataWharehouse

Ao abrir a solucao:

.sempre que for pedida a password: siad_bit_dev

.se for perguntando para actualizar a connection string fechar essa janela de dialogo, NUNCA FAZER OK!

.ignorar erros

.para simular o processamento do ETL basta executar o BitMainPackage.dtsx
