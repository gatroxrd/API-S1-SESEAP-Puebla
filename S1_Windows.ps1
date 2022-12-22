#!/bin/bash
    Set-Location c:\DeclaracionesPDN\API.SESEAP\USTPD.S1
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