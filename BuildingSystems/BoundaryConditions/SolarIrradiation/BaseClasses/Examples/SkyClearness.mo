within BuildingSystems.BoundaryConditions.SolarIrradiation.BaseClasses.Examples;
model SkyClearness "Test model for sky clearness"
  extends Modelica.Icons.Example;

  BuildingSystems.BoundaryConditions.SolarGeometry.ZenithAngle zen
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  BuildingSystems.BoundaryConditions.SolarIrradiation.BaseClasses.SkyClearness skyCle
    annotation (Placement(transformation(extent={{40,0},{60,20}})));

  BuildingSystems.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://BuildingSystems/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  BuildingSystems.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-2,20},{18,40}})));
equation
  connect(zen.y, skyCle.zen) annotation (Line(
      points={{-19,-10},{10,-10},{10,4},{38,4}},
      color={0,0,127}));

  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-20,30},{8,30}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.HDirNor, skyCle.HDirNor) annotation (Line(
      points={{8,30},{24,30},{24,16},{38,16}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.HDifHor, skyCle.HDifHor) annotation (Line(
      points={{8,30},{24,30},{24,10},{38,10}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(weaBus, zen.weaBus) annotation (Line(
      points={{8,30},{8,12},{-54,12},{-54,-10},{-40,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (
Documentation(info="<html>
<p>
This example computes the sky clearness.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 07, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
experiment(StartTime=100000, Tolerance=1e-6, StopTime=3000000),
__Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/BoundaryConditions/SolarIrradiation/BaseClasses/Examples/SkyClearness.mos"
        "Simulate and plot"));
end SkyClearness;
