within BuildingSystems.Fluid.Movers.Preconfigured.Validation;
model ControlledFlowMachinePreconfigured
  "Preconfigured fans with different control signals"
  extends Modelica.Icons.Example;
  extends BuildingSystems.Fluid.Movers.Validation.BaseClasses.ControlledFlowMachine(
    redeclare BuildingSystems.Fluid.Movers.Preconfigured.SpeedControlled_y fan1(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal),
    redeclare BuildingSystems.Fluid.Movers.Preconfigured.FlowControlled_m_flow fan2(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal),
    redeclare BuildingSystems.Fluid.Movers.Preconfigured.FlowControlled_dp fan3(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal),
    dp1(m_flow_nominal=m_flow_nominal, dp_nominal=dp_nominal),
    dp2(m_flow_nominal=m_flow_nominal, dp_nominal=dp_nominal),
    dp3(m_flow_nominal=m_flow_nominal, dp_nominal=dp_nominal));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=2
    "Nominal mass flow rate for each fan";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=500
    "Nominal pressure head for each fan";

      annotation (
experiment(Tolerance=1e-6, StopTime=600),
__Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Fluid/Movers/Preconfigured/Validation/ControlledFlowMachinePreconfigured.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model validates the preconfigured mover models.
It is based on
<a href=\"Modelica://BuildingSystems.Fluid.Movers.Validation.ControlledFlowMachineDynamic\">
BuildingSystems.Fluid.Movers.Validation.ControlledFlowMachineDynamic</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 21, 2023, by Hongxiang Fu:<br/>
Deleted the mover with <code>Nrpm</code> signal.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1704\">IBPSA, #1704</a>.
</li>
<li>
August 17, 2022, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-80},{160,160}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end ControlledFlowMachinePreconfigured;
