within BuildingSystems.Fluid.Movers.Preconfigured;
model SpeedControlled_y "Fan or pump with ideally controlled normalized speed y as input signal and pre-configured parameters"
  extends BuildingSystems.Fluid.Movers.SpeedControlled_y(
    final per(
            pressure(
              V_flow=m_flow_nominal/rho_default*{0, 1, 2},
              dp=if rho_default < 500
                   then dp_nominal*{1.12, 1, 0}
                   else dp_nominal*{1.14, 1, 0.42}),
            powerOrEfficiencyIsHydraulic=true,
            etaHydMet=BuildingSystems.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.EulerNumber,
            etaMotMet=BuildingSystems.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.GenericCurve),
    final inputType=BuildingSystems.Fluid.Types.InputType.Continuous,
    final init=Modelica.Blocks.Types.Init.InitialOutput,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial);

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(
    final min=Modelica.Constants.small)
    "Nominal mass flow rate for configuration of pressure curve"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal(
    final min=Modelica.Constants.small)
    "Nominal pressure head for configuration of pressure curve"
    annotation(Dialog(group="Nominal condition"));
annotation (
defaultComponentName="mov",
Documentation(info="<html>
<p>
This model is the preconfigured version for
<a href=\"Modelica://BuildingSystems.Fluid.Movers.SpeedControlled_y\">
BuildingSystems.Fluid.Movers.SpeedControlled_y</a>.
</html>", revisions="<html>
<ul>
<li>
March 1, 2023, by Hongxiang Fu:<br/>
Refactored the model with a new declaration for
<code>m_flow_nominal</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1705\">#1705</a>.
</li>
<li>
August 17, 2022, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
</ul>
</html>"));
end SpeedControlled_y;
