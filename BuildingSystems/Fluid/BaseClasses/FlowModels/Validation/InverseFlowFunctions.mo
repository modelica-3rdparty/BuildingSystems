within BuildingSystems.Fluid.BaseClasses.FlowModels.Validation;
model InverseFlowFunctions "Test model for flow function and its inverse"
  extends Modelica.Icons.Example;
  Modelica.Units.SI.MassFlowRate m_flow;
  Modelica.Units.SI.PressureDifference dp(displayUnit="Pa")
    "Pressure difference";
  Modelica.Units.SI.PressureDifference dpCalc(displayUnit="Pa")
    "Pressure difference computed by the flow functions";
  Modelica.Units.SI.Pressure deltaDp(displayUnit="Pa")
    "Pressure difference between input and output to the functions";
  Modelica.Units.SI.Time dTime=2;
 parameter Real k = 0.5;
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1 "Nominal flow rate";
equation
  dp = (time-0.5)/dTime * 20;
  m_flow=FlowModels.basicFlowFunction_dp(dp=dp, k=k, m_flow_turbulent=m_flow_nominal*0.3);
  dpCalc=FlowModels.basicFlowFunction_m_flow(m_flow=m_flow, k=k, m_flow_turbulent=m_flow_nominal*0.3);
  deltaDp = dp - dpCalc;
annotation (
experiment(Tolerance=1e-06, StopTime=1),
__Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Fluid/BaseClasses/FlowModels/Validation/InverseFlowFunctions.mos"
        "Simulate and plot"),
              Documentation(info="<html>
<p>
This model tests the inverse formulation of the flow functions.
The pressure difference <code>dp</code> and <code>dpCalc</code> need to
be equal up to the solver tolerance, except for a small neighborhood
around the origin. In this neighborhood around the origin, the functions
<a href=\"modelica://BuildingSystems.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp\">
BuildingSystems.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp</a>
and
<a href=\"modelica://BuildingSystems.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow\">
BuildingSystems.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow</a>
are not invertible.
</p>
</html>", revisions="<html>
<ul>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
August 8, 2012, by Michael Wetter:<br/>
Updated documentation.
</li>
<li>
July 12, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end InverseFlowFunctions;
