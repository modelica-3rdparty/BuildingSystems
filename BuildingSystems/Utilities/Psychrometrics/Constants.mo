within BuildingSystems.Utilities.Psychrometrics;
package Constants "Library of constants for psychometric functions"
  extends Modelica.Icons.Package;
  constant Modelica.Units.SI.Temperature T_ref=273.15
    "Reference temperature for psychrometric calculations";
  constant Modelica.Units.SI.SpecificHeatCapacity cpAir=1006
    "Specific heat capacity of air";
  constant Modelica.Units.SI.SpecificHeatCapacity cpSte=1860
    "Specific heat capacity of water vapor";
  constant Modelica.Units.SI.SpecificHeatCapacity cpWatLiq=4184
    "Specific heat capacity of liquid water";
  constant Modelica.Units.SI.SpecificEnthalpy h_fg=2501014.5
    "Enthalpy of evaporation of water at the reference temperature";
  constant Real k_mair = 0.6219647130774989 "Ratio of molar weights";

  annotation (
    Documentation(info="<html>
<p>
This package provides constants for functions used
in the calculation of thermodynamic properties of moist air.
</p>
</html>", revisions="<html>
<ul>
<li>
May 24, 2016, by Filip Jorissen:<br/>
Added reference temperature.
</li>
<li>
July 24, 2014, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={-9.2597,25.6673},
        fillColor={102,102,102},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,-15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,-0.097}},
        smooth=Smooth.Bezier),
      Polygon(
        origin={-19.9923,-8.3993},
        fillColor={102,102,102},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,-20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,37.145}},
        smooth=Smooth.Bezier),
      Polygon(
        origin={23.753,-11.5422},
        fillColor={102,102,102},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,-24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,41.214},{-2.671,41.214}},
        smooth=Smooth.Bezier)}));
end Constants;
