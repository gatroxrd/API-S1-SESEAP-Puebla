#!/bin/bash
    Set-Location c:\DeclaracionesPDN\API.SESEAP\USTPD.S1
	try
	{
		#Deten el contenedor dotnet
		docker stop $(docker ps -q --filter name=dotnet*)
		# Elimina el contenedor dotnet
		docker rm $(docker ps --filter status=exited -q)
		#Elimina la imagen dotnet
		docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}"|findstr "dotnet")
		#Revisión si quedo la imagen dotnet instalada
        docker image rm dotnet@latest -f
    }
    catch
    {
        docker image rm dotnet -f
    }
    docker build -t dotnet -f Dockerfile .
    docker run --name dotnet -p 9000:80 -d dotnet