 FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
 WORKDIR /app

 FROM base AS final
 WORKDIR /app
 COPY . .
 ENTRYPOINT ["dotnet", "PDEPuebla.S1.PDN.dll"]

