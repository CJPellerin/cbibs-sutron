Public Sub BLOCK_CorrWindDir
'---------------------------------------------------------------------------------------------------------------------
' BASIC processing block to convert wind direction from buoy reference to magnetic degrees reference.
' Adapted from Dewpoint block example in Sutron's BASIC.SLL manual
' Byron Kilbourne 20 June 2019
'
'---------------------------------------------------------------------------------------------------------------------

    ' Retrieve inputs
    'Temp = GetInputData(2)
    'TempQ = GetInputQuality(2)
    'Humid = GetInputData(4)
    'HumidQ = GetInputQuality(4)
    Wdir = GetInputData(2) ' direction from RM Young
    WdirQ = GetInputQuality(2) ' wind direction quality flag
    Cdir = GetInputData(4) ' direction from KVH compass
    CdirQ = GetInputQuality(4) ' compass direction quality flag

    ' Initialize attributes of result, assuming calculation will fail.
    'SetOutputUnits 3, "deg C"
    'SetOutputQuality 3, "B"
    'SetOutputData 3, 0.0
    SetOutputUnits 3, "Deg Mag"
    SetOutputQuality 3, "B"
    SetOutputData 3, 0.0

'    ' Verify quality of inputs check out.
'    'If TempQ = "G" And HumidQ = "G" Then
'        ' Test humidity range.
'        'If Humid >= 0.0 And Humid <= 100.0 Then
'            ' Test temperature range.
'            If Temp >= -60.0 And Temp <= 80.0 Then
'                DewPt = (0.057906 * log(Humid / 100.0) / 1.1805) + (Temp / Temp + 238.3)
'                DewPt = DewPt * 238.3 / (1.0 - DewPt)
'                SetOutputData 3, DewPt
'                SetOutputUnits 3, "C"
'                SetOutputQuality 3, "G"
'            Else
'                WarningMsg "Incoming temperature out-of-range."
'            End If
'        Else
'            WarningMsg "Incoming humidity out-of-range."
'        End If
'    Else
'        WarningMsg "Can't compute due to bad quality inputs."
'    End If

    ' Verify quality of inputs check out.
    'If WdirQ = "G" And CdirQ = "G" Then
        ' test Wdir range.
        'If Wdir >= 0.0 And Wdir <= 360.0 Then
            ' Test Cdir range.
            If Cdir >= 0.0 And Cdir <= 360.0 Then
                CorrDir = Wdir+Cdir
                If CorrDir >360 Then
                    CorrDir = CorrDir-360                
                End If                    
                SetOutputData 3, Corrdir
                SetOutputUnits 3, "Deg Mag"
                SetOutputQuality 3, "G"
            Else
                WarningMsg "Incoming compass out-of-range."
            End If
        Else
            WarningMsg "Incoming anemometer out-of-range."
        End If
    Else
        WarningMsg "Can't compute due to bad quality inputs."
    End If

End Sub
