within BuildingSystems.Fluid.HeatPumps.ModularReversible;
model LargeScaleWaterToWater
  "Model with automatic parameter estimation for large scale water-to-water heat pumps"
  extends BuildingSystems.Fluid.HeatPumps.ModularReversible.TableData2D(
    redeclare replaceable package MediumCon = BuildingSystems.Media.Water,
    redeclare replaceable package MediumEva = BuildingSystems.Media.Water,
    final mCon_flow_nominal=autCalMasCon_flow,
    final mEva_flow_nominal=autCalMasEva_flow,
    final tauCon=autCalVCon*rhoCon/autCalMasCon_flow,
    final tauEva=autCalVEva*rhoEva/autCalMasEva_flow);

  extends BuildingSystems.Fluid.HeatPumps.ModularReversible.BaseClasses.LargeScaleWaterToWaterDeclarations(
    final autCalMasCon_flow=max(4E-5*QHea_flow_nominal - 0.6162, autCalMMin_flow),
    final autCalMasEva_flow=max(4E-5*QHea_flow_nominal - 0.3177, autCalMMin_flow),
    final autCalVCon=max(1E-7*QHea_flow_nominal - 94E-4, autCalVMin),
    final autCalVEva=max(1E-7*QHea_flow_nominal - 75E-4, autCalVMin));

  annotation (Documentation(info="<html>
<p>
  Model using parameters for a large scale water-to-water heat pump,
  using the ModularReversible model approach.
</p>
<p>
  Contrary to the standard sizing approach for the
  <a href=\"modelica://BuildingSystems.Fluid.HeatPumps.ModularReversible.Modular\">
  BuildingSystems.Fluid.HeatPumps.ModularReversible.Modular</a> models,
  the parameters are based on an automatic estimation as described in
  <a href=\"modelica://BuildingSystems.Fluid.HeatPumps.ModularReversible.BaseClasses.LargeScaleWaterToWaterDeclarations\">
  BuildingSystems.Fluid.HeatPumps.ModularReversible.BaseClasses.LargeScaleWaterToWaterDeclarations</a>.
</p>
<p>
  For more information on the approach, please read the
  <a href=\"modelica://BuildingSystems.Fluid.HeatPumps.ModularReversible.UsersGuide\">
  UsersGuide</a>.
</p>
<p>
  Please read the documentation of the model for heating here:
  <a href=\"modelica://BuildingSystems.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData2D\">
  BuildingSystems.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData2D</a>.
</p>
<h4>Assumptions</h4>
<ul>
<li>
  As heat losses are implicitly included in the table
  data given by manufacturers, heat losses are disabled.
</li>
</ul>
</html>", revisions="<html><ul>
  <li>
    <i>Novemeber 11, 2022</i> by Fabian Wuellhorst:<br/>
    Implemented <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
</ul>
</html>"));
end LargeScaleWaterToWater;
