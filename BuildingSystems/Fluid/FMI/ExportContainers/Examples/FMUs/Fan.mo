within BuildingSystems.Fluid.FMI.ExportContainers.Examples.FMUs;
block Fan "Declaration of an FMU that exports a fan"
   extends BuildingSystems.Fluid.FMI.ExportContainers.ReplaceableTwoPort(
     redeclare replaceable package Medium =  BuildingSystems.Media.Air,
     redeclare final Movers.FlowControlled_dp com(
      nominalValuesDefineDefaultPressureCurve=true,
      final m_flow_nominal=m_flow_nominal,
      final use_inputFilter=
                          false,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.01
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal(displayUnit="Pa")
     = 500 "Pressure drop at nominal mass flow rate";

  Modelica.Blocks.Interfaces.RealInput dp_in(min=0, final unit="Pa")
    "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-120,68}),iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={-120,68})));

equation
  connect(dp_in, com.dp_in) annotation (Line(
      points={{-120,68},{-0.2,68},{-0.2,12}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
  Documentation(info="<html>
<p>
This example demonstrates how to export an FMU with a fluid flow component.
The FMU has an instance of
<a href=\"modelica://BuildingSystems.Fluid.Movers.FlowControlled_dp\">
BuildingSystems.Fluid.Movers.FlowControlled_dp</a>.
</p>
<p>
See
<a href=\"modelica://BuildingSystems.Fluid.FMI.UsersGuide\">
BuildingSystems.Fluid.FMI.UsersGuide</a> for why there is no model that exports
<a href=\"modelica://BuildingSystems.Fluid.Movers.FlowControlled_m_flow\">
BuildingSystems.Fluid.Movers.FlowControlled_m_flow</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 9, 2024, by Hongxiang Fu:<br/>
Specified <code>nominalValuesDefineDefaultPressureCurve=true</code>
in the mover component to suppress a warning.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3819\">#3819</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
November 3, 2014 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Fluid/FMI/ExportContainers/Examples/FMUs/Fan.mos"
        "Export FMU"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,14},{100,-16}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-58,48},{54,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{0,48},{0,-58},{54,0},{0,48}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}));
end Fan;
