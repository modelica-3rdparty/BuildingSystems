within BuildingSystems.Fluid.FMI.ExportContainers;
partial block ThermalZones
  "Partial block to export a model of multiple thermal zones as an FMU"

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = BuildingSystems.Media.Air "Moist air")));

  parameter Integer nZon(min=1)
    "Number of thermal zones in this container";
  parameter Integer nPorts(min=2)
    "Number of fluid ports for each zone (must be the same for every zone)";


  Interfaces.Inlet fluPor[nZon, nPorts](
    redeclare each final package Medium = Medium,
    each final use_p_in=false,
    each final allowFlowReversal=true) "Fluid connectors" annotation (Placement(
        transformation(extent={{-180,150},{-160,170}}), iconTransformation(
          extent={{-180,150},{-160,170}})));

  Adaptors.ThermalZone theZonAda[nZon](
    redeclare each final package Medium = Medium,
    each final nPorts=nPorts)
    "Adapter between the HVAC supply and return air, and its connectors for the FMU"
    annotation (Placement(transformation(extent={{-140,150},{-120,170}})));

equation
  for iZon in 1:nZon loop
    for iPor in 1:nPorts loop
      connect(theZonAda[iZon].fluPor[iPor], fluPor[iZon, iPor]) annotation (Line(points={{-142.2,160},{
          -142.2,160},{-144,160},{-170,160}},color={0,0,255}));
    end for;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},
            {160,180}}), graphics={Rectangle(
          extent={{-160,180},{160,-140}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-76,40},{86,152}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-64,270},{78,164}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-68,140},{74,52}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{74,112},{86,76}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{78,112},{82,76}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,-104},{86,8}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,-4},{74,-92}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{74,-32},{86,-68}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{78,-32},{82,-68}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{160,180}}),
        graphics={Text(
          extent={{-118,172},{-104,166}},
          textColor={0,0,127},
          textString="[%nZon, %nPorts]")}),
    Documentation(info="<html>
    <p>
Model that is used as a container for a multiple thermal zones
that are to be exported as an FMU.
</p>
<h4>Typical use and important parameters</h4>
<p>
To use this model as a container for an FMU, extend
from this model, rather than instantiate it,
add your thermal zones. For each thermal zone,
add a vector of mass flow rate sensors.
By extending from this model, the top-level
signal connectors on the left stay at the top-level, and hence
will be visible at the FMI interface.
</p>

Note that
<ul>
<li>
A vector of mass flow rate sensors is used to connect
one element of the thermal zone adapter with one thermal zone.
</li>
<li>
The size of the thermal zone adapter must be the same as the number
of vectors of mass flow rate sensors.
</li>
<li>
The vector of mass flow rate sensors must have the size <code>nPorts</code>.
</li>
<li>
All fluid ports of the mass flow rate sensor must be connected.
</li>
<li>
If mass flow rate sensors are not used, and your themal zone
has fluid ports which are autosized, then a direct connection between
an element of the thermal zone adpater <code>theZonAda</code> and your thermal
zone will be rejected. The reason is because autosized fluid ports
can only be connected to vector of ports whose sizes are literal.
</li>
</ul>

<p>
The example
<a href=\"modelica://BuildingSystems.Fluid.FMI.ExportContainers.Examples.FMUs.ThermalZones\">
BuildingSystems.Fluid.FMI.ExportContainers.Examples.FMUs.ThermalZones</a>
shows how multiple simple thermal zones can be implemented and exported as
an FMU.
<!-- @include_Buildings
The example
<a href=\"modelica://BuildingSystems.Fluid.FMI.ExportContainers.Validation.RoomHVAC\">
BuildingSystems.Fluid.FMI.ExportContainers.Validation.RoomHVAC</a>
shows how such an FMU can be connected
to an HVAC system that has signal flow.
-->
</p>

<p>
The conversion between the fluid ports and signal ports is done
in the thermal zone adapter <code>theZonAda[nZon]</code>.
This adapter has a vector of fluid ports called <code>ports[nPorts]</code>
which needs to be connected to the air volume of the thermal zones.
At this port, air exchanged between the thermal zones, the HVAC system
and any infiltration flow paths.
</p>
<p>
This model has input signals <code>fluPor[nZon, nPorts]</code> which carry
the mass flow rate for each flow that is connected to <code>ports[1:nPorts]</code>
for the respective zone, together with its
temperature, water vapor mass fraction per total mass of the air (not per kg dry
air), and trace substances. These quantities are always as if the flow
enters the respective room, even if the flow is zero or negative.
If a medium has no moisture, e.g., if <code>Medium.nXi=0</code>, or
if it has no trace substances, e.g., if <code>Medium.nC=0</code>, then
the output signal for these properties are removed.
Thus, a thermal zone model that uses these signals to compute the
heat added by the HVAC system need to implement an equation such as
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q<sub>sen</sub> = max(0, &#7745;<sub>sup</sub>) &nbsp; c<sub>p</sub> &nbsp; (T<sub>sup</sub> - T<sub>air,zon</sub>),
</p>
<p>
where
<i>Q<sub>sen</sub></i> is the sensible heat flow rate added to the thermal zone,
<i>&#7745;<sub>sup</sub></i> is the supply air mass flow rate from
the port <code>fluPor</code> (which is negative if it is an exhaust),
<i>c<sub>p</sub></i> is the specific heat capacity at constant pressure,
<i>T<sub>sup</sub></i> is the supply air temperature and
<i>T<sub>air,zon</sub></i> is the zone air temperature.
Note that without the <i>max(&middot;, &middot;)</i>, the energy
balance would be wrong.
For example,
<!-- @include_Buildings
models in the package
<a href=\"modelica://BuildingSystems.ThermalZones.Detailed\">
BuildingSystems.ThermalZones.Detailed</a> as well as
-->
the control volumes in
<a href=\"modelica://BuildingSystems.Fluid.MixingVolumes\">
BuildingSystems.Fluid.MixingVolumes</a>
implement such a <i>max(&middot;, &middot;)</i> function.
</p>
<p>
For each zone, its air temperature,
water vapor mass fraction per total mass of the air (unless <code>Medium.nXi=0</code>)
and trace substances (unless <code>Medium.nC=0</code>)
can be obtained from the outupt connector
<code>fluPor[1:nZon].backward</code>.
These signals are the same as the inflowing fluid stream(s)
at the port <code>theAdaZon[1:nZon].ports[1:nPorts]</code>.
The fluid connector <code>ports[nPorts]</code> has a prescribed mass flow rate, but
it does not set any pressure.
</p>
<p>
This model has a user-defined parameter <code>nPorts</code>
which sets the number of fluid ports, which in turn is used
for the ports <code>fluPor</code> and <code>ports</code>.
All zones must have the same number of fluid ports <code>nPorts</code>.
All <code>nPorts</code>
<code>ports[1:nPorts]</code> need to be connected as demonstrated in the example
<a href=\"modelica://BuildingSystems.Fluid.FMI.ExportContainers.Examples.FMUs.ThermalZones\">
BuildingSystems.Fluid.FMI.ExportContainers.Examples.FMUs.ThermalZones</a>.
</p>
<p>
<!-- @include_Buildings
The example
<a href=\"modelica://BuildingSystems.Fluid.FMI.ExportContainers.Validation.RoomHVAC\">
BuildingSystems.Fluid.FMI.ExportContainers.Validation.RoomHVAC</a>
shows conceptually how such an FMU can then be connected to a HVAC system
that has signal flow.
-->
</p>
</html>", revisions="<html>
<ul>
<li>
January 18, 2019, by Jianjun Hu:<br/>
Limited the media choice to moist air.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1050\">#1050</a>.
</li>
<li>
September 20, 2016, by Thierry S. Nouidui:<br/>
Revised documentation to explain the rationale
of needing mass flow rate sensors.
</li>
<li>
June 29, 2016, by Michael Wetter:<br/>
Revised implementation and documentation.
</li>
<li>
April 27, 2016, by Thierry S. Nouidui:<br/>
First implementation.
</li>
</ul>
</html>"));
end ThermalZones;
