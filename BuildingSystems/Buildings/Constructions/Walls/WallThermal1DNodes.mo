within BuildingSystems.Buildings.Constructions.Walls;
model WallThermal1DNodes
  "Thermal wall model with 1D discritisation of the single layers"
  extends BuildingSystems.Buildings.BaseClasses.WallThermalGeneral;
  BuildingSystems.Interfaces.HeatPort heatPort_source if heatSource
    annotation (Placement(transformation(extent={{-10,-48},{10,-28}}),
       iconTransformation(extent={{-10,-48},{10,-28}})));
  BuildingSystems.HAM.HeatConduction.MultiLayerHeatConduction1DNodes construction(
    lengthY=width_internal,
    lengthZ=height_internal,
    nLayers=constructionData.nLayers,
    nNodes=nNodes,
    thickness=constructionData.thickness,
    material=constructionData.material,
    T_start=T_start,
    layerWithHeatSource=layerWithHeatSource,
    nodeWithHeatSource=nodeWithHeatSource)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter Integer nNodes[constructionData.nLayers] = fill(1,constructionData.nLayers)
    "Number of numerical nodes of each layer"
    annotation(Dialog(tab = "Advanced", group = "Numerical Parameters"));
  parameter Integer nodeWithHeatSource = 1
    "Numerical node of the specified layer with internal heat source"
    annotation(Dialog(tab = "Advanced", group = "Heat sources"));
  parameter Boolean show_TSur = false
    "Show surface temperatures on both sides"
    annotation(Dialog(tab = "Advanced", group = "Surface variables"));
  BuildingSystems.Interfaces.Temp_KOutput TSur_1 = toSurfacePort_1.heatPort.T if show_TSur
    "Temperature on surface side 1"
    annotation (Placement(transformation(extent={{-40,30},{-60,50}}),
      iconTransformation(extent={{-20,30},{-40,50}})));
  BuildingSystems.Interfaces.Temp_KOutput TSur_2 = toSurfacePort_2.heatPort.T if show_TSur
    "Temperature on surface side 2"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},origin={50,40}),
      iconTransformation(extent={{20,30},{40,50}})));
  parameter Modelica.Units.SI.Area AInnSur=0.0
    "Area of all enclosed surfaces (if geometryType == Fixed)"
    annotation (Dialog(tab="Geometry", group="General"));
  output BuildingSystems.Interfaces.AreaOutput AInnSur_internal
    "Area of all enclosed surfaces";
  input BuildingSystems.Interfaces.AreaInput AInnSur_in(
    min=0) if geometryType == BuildingSystems.Buildings.Types.GeometryType.Flexible
    "Area of all enclosed surfaces from input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,  origin={-30,-56}),
          iconTransformation(extent={{10,-10},{-10,10}},rotation=180,origin={-20,-60})));
equation
  // Geometry
  ASur = height_internal * width_internal - AInnSur_internal;
  if geometryType == BuildingSystems.Buildings.Types.GeometryType.Fixed then
    AInnSur_internal = AInnSur;
  else
    connect(AInnSur_internal, AInnSur_in);
  end if;
  // Energy and moisture transport
  connect(heatPort_source, construction.heatPort_source);
  connect(toSurfacePort_1.moisturePort, moistBcPort1.moisturePort) annotation (Line(
    points={{-20,0},{-20,-11.2}},
    color={0,0,0},
    pattern=LinePattern.Solid,
    smooth=Smooth.None));
  connect(toSurfacePort_2.moisturePort, moistBcPort2.moisturePort) annotation (Line(
      points={{20,0},{20,-11.2}},
      color={0,0,0},
      pattern=LinePattern.Solid,
      smooth=Smooth.None));
  connect(construction.heatPort_x2, toSurfacePort_2.heatPort) annotation (Line(
      points={{8,0},{20,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(toSurfacePort_1.heatPort, construction.heatPort_x1) annotation (Line(
      points={{-20,0},{-8,0}},
      color={0,0,0},
      pattern=LinePattern.Solid,
      smooth=Smooth.None));

  annotation (defaultComponentName="wall", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),graphics={
    Text(extent={{-16,81},{16,38}}, lineColor={255,0,0},lineThickness=0.5,fillColor={255,128,0},fillPattern = FillPattern.Solid,textString = "1D"),
    Text(extent={{-66,146},{66,106}},lineColor={0,0,255},fillColor={230,230,230},fillPattern = FillPattern.Solid,textString = "%name")}),
Documentation(info="<html>
<p>
This is a thermal wall model with 1D discritisation of the single layers.
</p>
</html>", revisions="<html>
<ul>
<li>
April 24, 2019 by Christoph Nytsch-Geusen:<br/>
Adaptation to flexible geometries.
</li>
<li>
May 23, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end WallThermal1DNodes;
