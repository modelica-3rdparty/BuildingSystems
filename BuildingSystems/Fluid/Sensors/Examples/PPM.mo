within BuildingSystems.Fluid.Sensors.Examples;
model PPM "Test model for the extra property sensor outputting PPM"
  extends Modelica.Icons.Example;
  package Medium = BuildingSystems.Media.Air(extraPropertiesNames={"CO2"})
    "Medium model";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=
    volDyn.V*senPPMTwoPort.tau*3*rho_default
    "Mass flow rate into and out of the volume";

  BuildingSystems.Fluid.MixingVolumes.MixingVolume volDyn(
    redeclare package Medium = Medium,
    nPorts=3,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    V=1,
    use_C_flow=true,
    m_flow_nominal=m_flow_nominal) "Mixing volume with dynamics"
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T mSou(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow=m_flow_nominal) "Fresh air supply"
    annotation (Placement(transformation(origin = {-28, 0}, extent = {{-40, 30}, {-20, 50}})));

  BuildingSystems.Fluid.Sensors.PPM senPPMVol(
    redeclare package Medium = Medium,
    warnAboutOnePortConnection=false)
    "PPM sensor for mixing volume"
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
  Modelica.Blocks.Sources.Constant CO2In(k=m_flow_nominal/1000)
    "CO2 mass flow rate entering mixing volume"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  BuildingSystems.Fluid.Sensors.PPMTwoPort senPPMTwoPort(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal) "PPM sensor" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,10})));
  BuildingSystems.Fluid.Sensors.PPM senPPMIn(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    "PPM sensor for inlet"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  BuildingSystems.Fluid.Sensors.PPMTwoPort senPPMNoRev(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal) "PPM sensor without flow reversal disabled"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-30})));
  BuildingSystems.Fluid.Sensors.PPMTwoPort senPPMRev(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal) "PPM sensor with flow in reverse direction"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,-50})));
  BuildingSystems.Fluid.Sensors.PPMTwoPort senPPMSta(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=0,
    m_flow_nominal=m_flow_nominal) "Static PPM sensor" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        origin={10,-50})));
  BuildingSystems.Fluid.MixingVolumes.MixingVolume volSte(
    redeclare package Medium = Medium,
    nPorts=3,
    V=1,
    use_C_flow=true,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Mixing volume without dynamics"
    annotation (Placement(transformation(extent={{70,80},{90,100}})));
  BuildingSystems.Fluid.Sensors.PPM senPPMVol2( redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    "PPM sensor for mixing volume"
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T mSouSta(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=m_flow_nominal) "Fresh air supply for steady state volume"
    annotation (Placement(transformation(origin = {-28, 0}, extent = {{-40, 110}, {-20, 130}})));
  BuildingSystems.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    nPorts=2) "Exhaust air"
    annotation (Placement(transformation(origin = {-30, 0}, extent = {{-40, -60}, {-20, -40}})));

  BuildingSystems.Fluid.FixedResistances.PressureDrop dp(
     redeclare package Medium = Medium,
     dp_nominal = 200,
     m_flow_nominal = m_flow_nominal)
     "Pressure drop to decouple volume pressure from boundary pressure"
     annotation (
    Placement(transformation(origin = {-28, -50}, extent = {{-2, -10}, {18, 10}})));

protected
  final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values"
    annotation(Evaluate=true);
  // Density at medium default values, used to compute the size of control volumes
  final parameter Modelica.Units.SI.Density rho_default=Medium.density(
    state=state_default)
    "Density, used to compute fluid mass"
    annotation(Evaluate=true);

equation
  connect(mSou.ports[1], volDyn.ports[1]) annotation (Line(points={{-48,39},{
          -48,50},{78.6667,50}},
                            color={0,127,255}));
  connect(CO2In.y, volDyn.C_flow[1]) annotation (Line(points={{21,70},{32,70},{32,
          54},{68,54}}, color={0,0,127}));
  connect(senPPMVol.port, volDyn.ports[2]) annotation (Line(points={{130,40},{80,
          40},{80,50}},color={0,127,255}));
  connect(senPPMIn.port, mSou.ports[2])
    annotation (Line(points={{-10,80},{-10,41},{-48,41}}, color={0,127,255}));
  connect(senPPMTwoPort.port_a, volDyn.ports[3]) annotation (Line(points={{80,20},
          {80,50},{81.3333,50}},         color={0,127,255}));
  connect(senPPMNoRev.port_a, senPPMTwoPort.port_b)
    annotation (Line(points={{80,-20},{80,0}}, color={0,127,255}));
  connect(senPPMRev.port_b, senPPMNoRev.port_b) annotation (Line(points={{60,-50},
          {80,-50},{80,-40}},          color={0,127,255}));
  connect(senPPMSta.port_a, senPPMRev.port_a)
    annotation (Line(points={{20,-50},{30,-50},{40,-50}}, color={0,127,255}));
  connect(CO2In.y,volSte. C_flow[1]) annotation (Line(points={{21,70},{32,70},{32,
          84},{68,84}}, color={0,0,127}));
  connect(volSte.ports[1], senPPMVol2.port) annotation (Line(points={{78.6667,
          80},{130,80}},          color={0,127,255}));
  connect(mSouSta.ports[1], volSte.ports[2]) annotation (Line(points={{-48,120},
          {54,120},{54,80},{80,80}},      color={0,127,255}));
  connect(sin.ports[1], volSte.ports[3]) annotation (
    Line(points={{-50,-51},{-50,-80},{110,-80},{110,80},{81.3333,80}},            color = {0, 127, 255}));
  connect(dp.port_b, senPPMSta.port_b) annotation (
    Line(points = {{-10, -50}, {0, -50}}, color = {0, 127, 255}));
  connect(dp.port_a, sin.ports[2]) annotation (
    Line(points={{-30,-50},{-40,-50},{-40,-49},{-50,-49}},
                                            color = {0, 127, 255}));
    annotation (
experiment(Tolerance=1e-6, StopTime=3),
__Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Fluid/Sensors/Examples/PPM.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{180,
            180}})),
    Documentation(info="<html>
<p>
This example tests the sensors that measure trace substances
using an output in parts per million.
Various configurations with and without flow reversal
and with or without dynamics are tested.
</p>
</html>",
revisions="<html>
<ul>
<li>
February 1, 2024, by Michael Wetter:<br/>
Added pressure drop to avoid redundant initial conditions for pressure of control volume.<br/>
This is for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1830\"> #1830</a>.
</li>
<li>
May 2, 2019, by Jianjun Hu:<br/>
Replaced fluid source. This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1072\"> #1072</a>.
</li>
<li>
January 12, 2016, by Filip Jorissen:<br/>
First implementation.
See issue
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/372\">#372</a>
</li>
</ul>
</html>"));
end PPM;
