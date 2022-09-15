FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /
EXPOSE 80
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /
COPY ["demo-teis.csproj", "."]
RUN dotnet restore "./demo-teis.csproj"
COPY . .
WORKDIR "/."
RUN dotnet build "demo-teis.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "demo-teis.csproj" -c Release -o /app/publish
FROM base AS final
#WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "demo-teis.dll"]