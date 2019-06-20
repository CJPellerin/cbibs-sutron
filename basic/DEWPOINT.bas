Public Sub BLOCK_DewPoint
' Retrieve inputs.
Temp = GetInputData(2)
TempQ = GetInputQuality(2)
Humid = GetInputData(4)
HumidQ = GetInputQuality(4)
' Initialize attributes of result, assuming calculation will fail.
SetOutputUnits 3, "deg C"
SetOutputQuality 3, "B"
SetOutputData 3, 0.0
' Verify quality of inputs check out.
If TempQ = "G" And HumidQ = "G" Then
If Humid >= 0.0 And Humid <= 100.0 Then
' Test temperature range.
If Temp >= -60.0 And Temp <= 80.0 Then
DewPt = (0.057906 * log(Humid / 100.0) / 1.1805) + (Temp / Temp +
238.3)
DewPt = DewPt * 238.3 / (1.0 - DewPt)
SetOutputData 3, DewPt
SetOutputQuality 3, "G"
Else
WarningMsg "Incoming temperature out-of-range."
End If
Else
WarningMsg "Incoming humidity out-of-range."
End If
Else
WarningMsg "Can't compute due to bad quality inputs."
End If
End Sub
