#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
COPY **/Images/*.jpg /app/Images/
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
RUN dotnet dev-certs https
WORKDIR /src
COPY ["DentalOffice.API/DentalOffice.API.csproj", "DentalOffice.API/"]
COPY ["DentalOffice.Dtos/DentalOffice.Dtos.csproj", "DentalOffice.Dtos/"]
COPY ["DentalOffice.Enums/DentalOffice.Enums.csproj", "DentalOffice.Enums/"]
COPY ["DentalOffice.Entities/DentalOffice.Entities.csproj", "DentalOffice.Entities/"]
COPY ["DentalOffice.Mapper/DentalOffice.Mapper.csproj", "DentalOffice.Mapper/"]
COPY ["DentalOffice.Repositories/DentalOffice.Repositories.csproj", "DentalOffice.Repositories/"]
RUN dotnet restore "DentalOffice.API/DentalOffice.API.csproj"
COPY . .
WORKDIR "/src/DentalOffice.API"
RUN dotnet build "DentalOffice.API.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "DentalOffice.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /root/.dotnet/corefx/cryptography/x509stores/my/* /root/.dotnet/corefx/cryptography/x509stores/my/
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DentalOffice.API.dll"]