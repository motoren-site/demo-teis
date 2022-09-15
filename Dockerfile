FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /
    
# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

RUN dotnet publish -c Release -o out
    
# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "demo-teis.dll"]