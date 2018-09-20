within BuildingSystems.Climate.WeatherDataTRYGermany;
block Germany_Hof_TRYnormal_NetCDF
  extends BuildingSystems.Climate.WeatherData.BaseClasses.WeatherDataFileNetCDF(
  info="Source: German TRY",
  fileName=Modelica.Utilities.Files.loadResource("modelica://BuildingSystems/Climate/weather/Germany_HofTRYnormal_waether.nc"))
  annotation(Documentation(info="<html>source: German Test Reference Year</html>"));
end Germany_Hof_TRYnormal_NetCDF;