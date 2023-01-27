 FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
 WORKDIR /app

 FROM base AS final
 WORKDIR /app
 COPY . .
 
 #27 Ene 2023 GRD
 #Personalizando el nombre del contenedor a:
 #declaraciones-api-interconexion-puebla
 #ENTRYPOINT ["dotnet", "PDEPuebla.S1.PDN.dll"]
 
 ENTRYPOINT ["declaraciones-api-interconexion-puebla", "PDEPuebla.S1.PDN.dll"]

