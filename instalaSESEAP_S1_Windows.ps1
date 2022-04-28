Write-Host "Felicidades! Su script esta listo para ejecutarse!!"

#!/bin/bash

Write-Output "+ + + + + + + + + + + API S1 Conexion Entes - SESEAP - PDN + + + + + + + + + + + + + + + + + + +"
Write-Output "Script de descarga,instalacion y montado en el contenedor Docker de la API SESEAP S1"
Write-Output ""
Write-Output "Secretaria Ejecutiva del Sistema Estatal Anticorrupcion de Puebla (SESEAP)"
Write-Output "Unidad de Servicios Tecnologicos y Plataforma Digital (USTPD)"
Write-Output "                                                                            Version Windows al 22 de abril de 2022"
Write-Output "+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + "


	#sudo apt install zip unzip
	#set -a
	#source <(cat parametrosConfiguracion.txt|\
	#	sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
	#set +a


	Write-Output "Iniciando descarga del proyecto .NET del repositorio GitHub de USTPD-SESEAP"
    #    sudo rm -rf API.S1.SESEAP
	Remove-Item -Recurse -Force c:\DeclaracionesPDN\API.S1.SESEAP
	#mkdir API.S1.SESEAP
	New-Item -Path "c:\DeclaracionesPDN" -Name "API.S1.SESEAP" -ItemType "directory"
	Set-Location c:\DeclaracionesPDN\API.S1.SESEAP
	Invoke-WebRequest -Uri https://github.com/gatroxrd/API-S1-SESEAP-Puebla/raw/main/PDEPuebla.S1.PDN.zip -OutFile PDEPuebla.S1.PDN.zip
	Write-Output "Descomprimiendo archivos descargados"
	
	Expand-Archive -LiteralPath 'c:\DeclaracionesPDN\API.S1.SESEAP\PDEPuebla.S1.PDN.zip' -DestinationPath 'C:\DeclaracionesPDN\API.S1.SESEAP'
	Write-Output "Eliminando archivo .zip"
	#rm  PDEPuebla.S1.PDN.zip
    Remove-Item -Recurse -Force C:\DeclaracionesPDN\API.S1.SESEAP\PDEPuebla.S1.PDN.zip

    Write-Output "Cargando y procesando el archivo con los parametros de Configuracion"

    #Obteniendo valores del archivo de parametros de configuración

    $content = Get-Content -Path 'c:\DeclaracionesPDN\parametrosConfiguracion.txt';
    
    $temporal = $content | Where-Object {$_ -like "apiName=*" }
    $apiname = $temporal -replace 'apiName=',''
  	#sed -i "s/valorW/$apiname/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorW',$apiname | Set-Content .\appsettings.json

    $temporal = $content | Where-Object {$_ -like "clientid=*" }
    $clientid = $temporal -replace 'clientid=',''
	#sed -i "s/valorX/$clientid/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorX',$clientid | Set-Content .\appsettings.json

    $temporal = $content | Where-Object {$_ -like "clientLectura=*" }
    $clientLectura = $temporal -replace 'clientLectura=',''
	#sed -i "s/valorLectura/$clientLectura/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorLectura',$clientLectura | Set-Content .\appsettings.json

    $temporal = $content | Where-Object {$_ -like "clientEscritura=*" }
    $clientEscritura = $temporal -replace 'clientEscritura=',''
	#sed -i "s/valorEscritura/$clientEscritura/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorEscritura',$clientEscritura | Set-Content .\appsettings.json

    $temporal = $content | Where-Object {$_ -like "IP_HOSTNAME=*" }
    $IP_HOSTNAME = $temporal -replace 'IP_HOSTNAME=',''
	#sed -i "s/valorY/$IP_HOSTNAME/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorY',$IP_HOSTNAME | Set-Content .\appsettings.json
    
    $temporal = $content | Where-Object {$_ -like "entidad=*" }
    $entidad = $temporal -replace 'entidad=',''
	#sed -i "s/valorZ/$entidad/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorZ',$entidad | Set-Content .\appsettings.json


    $temporal = $content | Where-Object {$_ -like "MONGO_USERNAME=*" }
    $valorusr = $temporal -replace 'MONGO_USERNAME=',''
	#sed -i "s/valorusr/$MONGO_USERNAME/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorusr',$valorusr | Set-Content .\appsettings.json

    $temporal = $content | Where-Object {$_ -like "MONGO_PASSWORD=*" }
    $valorpsw = $temporal -replace 'MONGO_PASSWORD=',''
	#sed -i "s/valorpsw/$MONGO_PASSWORD/g" appsettings.json
    (Get-Content -path C:\DeclaracionesPDN\API.S1.SESEAP\appsettings.json -Raw) -replace 'valorpsw',$valorpsw | Set-Content .\appsettings.json

    $temporal = $content | Where-Object {$_ -like "PORT_HOSTNAME=*" }
    $PORT_HOSTNAME = $temporal -replace 'PORT_HOSTNAME=',''

	Write-Output "La informacion que proporciono en su archivo parametrosConfiguracion.txt ya actualizo su archivo appSettings.json"
	Write-Output "Los recursos externos necesarios ya fueron descargados"
	Write-Output "La informacion requerida para configurar el entorno de trabajo ya esta lista para consumirse."


	Write-Output "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
	Write-Output "Iniciando despliegue de la API Microsoft .NET"

	Write-Output "= = = = = = = = = = = = = = = = = = = = = = = P A S O  1 = = = = = = = = = = = = = = = = = = = = = = ="
	Write-Output "Eliminando imagen previa del contenedor Docker llamada:" 
	#sudo docker rm -f dotnet
	Write-Output "= = = = = = = = = = = = = = = = = = = = = = = P A S O  2 = = = = = = = = = = = = = = = = = = = = = = ="
	Write-Output "Construyendo la imagen a partir del proyecto .NET"	
	#sudo docker build -t dotnet -f Dockerfile .
	Write-Output "= = = = = = = = = = = = = = = = = = = = = = = P A S O  3 = = = = = = = = = = = = = = = = = = = = = = ="
	Write-Output "ID de la imagen dentro del contenedor Docker es:"
	#sudo docker run --restart always --name dotnet -p $PORT_HOSTNAME:80 -d dotnet
	Write-Output "En adelante usted puede abrir en cualquier navegador de su red local la API capturando la url con la ip de su equipo más el puerto ${puerto}"
	Write-Output ""


	Write-Output  "                            C O N E X I O N   E S T A B L E C I D A!"
	Write-Output  "________________________________________________________________________________________________________________________________"
