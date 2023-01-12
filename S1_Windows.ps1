#!/bin/bash
    Set-Location c:\DeclaracionesPDN\API.SESEAP\USTPD.S1
	try
	{
		#docker container stop $(docker container ls -q --filter name=dotnet*) | xargs docker rm
		docker-machine stop dotnet@latest
		Remove-Container -ContainerIdOrName --filter name=dotnet*
		#docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}"|findstr "dotnet")
		docker images --format='{{json .}}'|Select-String -Pattern "${dotnet}" |   ConvertFrom-Json |  ForEach-Object -process { docker rmi -f $_.ID}
	}
	catch
	{
		
	}
    try
    {
        docker image rm dotnet@latest -f
    }
    catch
    {
        docker image rm dotnet -f
    }
    docker build -t dotnet -f Dockerfile .
    docker run --name dotnet -p 9000:80 -d dotnet