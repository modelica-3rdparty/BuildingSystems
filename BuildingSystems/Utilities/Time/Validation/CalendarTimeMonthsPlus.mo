within BuildingSystems.Utilities.Time.Validation;
model CalendarTimeMonthsPlus
  "Validation model for the calendar time model with start time slightly higher than the full hour"
  extends BuildingSystems.Utilities.Time.Validation.CalendarTimeMonths;

  annotation (
    __Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Utilities/Time/Validation/CalendarTimeMonthsPlus.mos"
        "Simulate and plot"),
  Documentation(
    info="<html>
<p>
This model validates the use of the
<a href=\"modelica://BuildingSystems.Utilities.Time.CalendarTime\">
BuildingSystems.Utilities.Time.CalendarTime</a>.
It is identical to
<a href=\"modelica://BuildingSystems.Utilities.Time.Validation.CalendarTimeMonths\">
BuildingSystems.Utilities.Time.Validation.CalendarTimeMonths</a>
except that the start and end time are different.
</p>
</html>",
revisions="<html>
<ul>
<li>
September 14, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(StartTime=172801, Tolerance=1e-6, StopTime=345601));
end CalendarTimeMonthsPlus;
