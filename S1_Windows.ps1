#!/bin/bash
    Set-Location c:\DeclaracionesPDN\API.SESEAP\USTPD.S1
	try
	{
		#27 Ene 2023 GRD
		#Personalizando el nombre del contenedor de dotnet = => declaraciones-api-interconexion-puebla
		
		#Deten el contenedor dotnet - declaraciones-api-interconexion-puebla
		docker stop $(docker ps -q --filter name=declaraciones-api-interconexion-puebla*)
		# Elimina el contenedor dotnet - declaraciones-api-interconexion-puebla
		docker rm $(docker ps --filter status=exited -q)
		#Elimina la imagen dotnet - declaraciones-api-interconexion-puebla
		docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}"|findstr "declaraciones-api-interconexion-puebla")
		#Revisión si quedo la imagen dotnet instalada
        docker image rm declaraciones-api-interconexion-puebla@latest -f
    }
    catch
    {
        docker image rm declaraciones-api-interconexion-puebla -f
    }
    docker build -t declaraciones-api-interconexion-puebla -f Dockerfile .
    docker run --restart always --name declaraciones-api-interconexion-puebla -p 9000:80 -d declaraciones-api-interconexion-puebla