within BuildingSystems.Fluid.HeatPumps.ModularReversible.Validation.Comparative;
model ConstantCarnotEffectiveness
  "Validation case for modular Carnot approach"
  extends BaseClasses.PartialModularComparison(heaPum(redeclare model
        RefrigerantCycleHeatPumpHeating =
          BuildingSystems.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.ConstantCarnotEffectiveness
          (etaCarnot_nominal=etaCarnot_nominal)));
  extends Modelica.Icons.Example;

  annotation (experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Fluid/HeatPumps/ModularReversible/Validation/Comparative/ConstantCarnotEffectiveness.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
November 13, 2023 by Fabian Wuellhorst:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Validation case for <a href=\"modelica://BuildingSystems.Fluid.Chillers.ModularReversible.RefrigerantCycle.ConstantCarnotEffectiveness\">
BuildingSystems.Fluid.Chillers.ModularReversible.RefrigerantCycle.ConstantCarnotEffectiveness</a>.
</p>
</html>"));
end ConstantCarnotEffectiveness;
