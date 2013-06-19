# SIAD\com.isel.siad.sv1213.bit

## Requirements[PT]:
1. SQL Server Business Intelligence Development Studio 9 (2008) instalado e funcional.
2. Acesso à Internet

## Configuration Notes[PT]:
Antes de abrir a solucao com.isel.siad.sv1213.bit.sln, efectuar as seguintes configuracoes:

1) Executar o script \#SQL\ETL\00-create_db-DataStagingBIT.sql no Database Engine

2) Executar o script \#XMLA\01-create-com isel siad sv1213 bit ssas.xmla no Analisys Services

3) Configurar os servidores alvos, e directorias locais nos ficheiros:
	BitMainPackage.Connections.dtsConfig
	BitMainPackage.Variables.dtsConfig
	BitMainPackage.dtsx
	FinacialPackage.Connections.dtsConfig
	FinacialPackage.Variables.dtsConfig
	FinacialPackage.dtsx
	OperationalPackage.Connections.dtsConfig
	OperationalPackage.dtsx

Ao abrir a solucao:

.sempre que for pedida a password: siad_bit_dev

.se for perguntando para actualizar a connection string fechar essa janela de dialogo