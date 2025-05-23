within BuildingSystems.Electrical.Transmission;
package LowVoltageCables "Package of low voltage electricity cables used in distribution grid"
  extends Modelica.Icons.MaterialPropertiesPackage;

annotation (Documentation(info="<html>
<p>
This package contains records of physical properties for low
voltage commercial cables. New cables can be added by extending the
base record
<a href=\"modelia://BuildingSystems.Electrical.Transmission.LowVoltageCables.Generic\">
BuildingSystems.Electrical.Transmission.LowVoltageCables.Generic</a>.
</p>
<p>
For low voltage cables, only the characteristic resistance and reactance are
specified. See <a href=\"modelia://BuildingSystems.Electrical.Transmission.Base.BaseCable\">
BuildingSystems.Electrical.Transmission.Base.BaseCable</a> for a comprehensive list of
parameters that can be specified for a cable.
</p>
</html>", revisions="<html>
<ul>
<li>
June 3, 2014, by Marco Bonvini:<br/>
Added User's guide.
</li>
</ul>
</html>"));
end LowVoltageCables;
