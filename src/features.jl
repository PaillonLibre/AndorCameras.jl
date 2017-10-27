#
# features.jl --
#
# Definitions of features for Andor cameras.
#
#-------------------------------------------------------------------------------
#
# This file is part of "AndorCameras.jl" released under the MIT license.
#
# Copyright (C) 2017, Éric Thiébaut.
#

module Features

import
    ..AbstractFeature,
    ..CommandFeature,
    ..BooleanFeature,
    ..EnumeratedFeature,
    ..IntegerFeature,
    ..FloatingPointFeature,
    ..StringFeature,
    ..BooleanOrEnumeratedFeature,
    ..@L_str,
    ..isavailable,
    ..isimplemented,
    ..widestring

# Export the following methods for those who `using AndorCameras.Features`
# (feature constants will be exported while being defined below):
export
    isavailable,
    isimplemented

for (sym, T) in ((:AccumulateCount, IntegerFeature),
                 (:AOIBinning, EnumeratedFeature),
                 (:AOIHBin, IntegerFeature),
                 (:AOIHeight, IntegerFeature),
                 (:AOILayout, EnumeratedFeature),
                 (:AOILeft, IntegerFeature),
                 (:AOIStride, IntegerFeature),
                 (:AOITop, IntegerFeature),
                 (:AOIVBin, IntegerFeature),
                 (:AOIWidth, IntegerFeature),
                 (:AcquisitionStart, CommandFeature),
                 (:AcquisitionStop,  CommandFeature),
                 (:AlternatingReadoutDirection, BooleanFeature),
                 (:AuxiliaryOutSource, EnumeratedFeature),
                 (:AuxiliaryOutSourceTwo, EnumeratedFeature),
                 (:BackoffTemperatureOffset, FloatingPointFeature),
                 (:Baseline, IntegerFeature),
                 (:BaselineLevel, IntegerFeature), # FIXME: deprcated?
                 (:BitDepth, EnumeratedFeature),
                 (:BufferOverflowEvent, IntegerFeature),
                 (:BytesPerPixel, FloatingPointFeature),
                 (:CameraAcquiring, BooleanFeature),
                 (:CameraDump, CommandFeature),
                 (:CameraFamily, StringFeature),
                 (:CameraMemory, IntegerFeature),
                 (:CameraModel, StringFeature),
                 (:CameraName, StringFeature),
                 (:CameraPresent, BooleanFeature),
                 (:ColourFilter, EnumeratedFeature),
                 (:ControllerID, StringFeature),
                 (:CoolerPower, FloatingPointFeature),
                 (:CycleMode, EnumeratedFeature),
                 (:DDGIOCEnable, BooleanFeature),
                 (:DDGIOCNumberOfPulses, IntegerFeature),
                 (:DDGIOCPeriod, IntegerFeature),
                 (:DDGInsertionDelay, EnumeratedFeature),
                 (:DDGOpticalWidthEnable, BooleanFeature),
                 (:DDGOutputDelay, IntegerFeature),
                 (:DDGOutputEnable, BooleanFeature),
                 (:DDGOutputPolarity, EnumeratedFeature),
                 (:DDGOutputSelector, EnumeratedFeature),
                 (:DDGOutputStepEnable, BooleanFeature),
                 (:DDGOutputWidth, IntegerFeature),
                 (:DDGQueue, CommandFeature),
                 (:DDGStepCount, IntegerFeature),
                 (:DDGStepDelayCoefficientA, FloatingPointFeature),
                 (:DDGStepDelayCoefficientB, FloatingPointFeature),
                 (:DDGStepDelayMode, EnumeratedFeature),
                 (:DDGStepEnabled, BooleanFeature),
                 (:DDGStepUploadModeValues, CommandFeature),
                 (:DDGStepUploadProgress, IntegerFeature),
                 (:DDGStepUploadRequired, BooleanFeature),
                 (:DDGStepWidthCoefficientA, FloatingPointFeature),
                 (:DDGStepWidthCoefficientB, FloatingPointFeature),
                 (:DDGStepWidthMode, EnumeratedFeature),
                 (:DDR2Type, StringFeature),
                 (:DeviceCount, IntegerFeature),
                 (:DeviceVideoIndex, IntegerFeature),
                 (:DisableShutter, BooleanFeature),
                 (:DriverVersion, StringFeature),
                 (:ElectronicShutteringMode, EnumeratedFeature),
                 (:EventEnable, BooleanFeature),
                 (:EventSelector, EnumeratedFeature),
                 (:EventsMissedEvent, IntegerFeature),
                 (:ExposedPixelHeight, IntegerFeature),
                 (:ExposureEndEvent, IntegerFeature),
                 (:ExposureStartEvent, IntegerFeature),
                 (:ExposureTime, FloatingPointFeature),
                 (:ExternalIOReadout, BooleanFeature),
                 (:ExternalTriggerDelay, FloatingPointFeature),
                 (:FanSpeed, EnumeratedFeature),
                 (:FastAOIFrameRateEnable, BooleanFeature),
                 (:FirmwareVersion, StringFeature),
                 (:ForceShutterOpen, BooleanFeature),
                 (:FrameCount, IntegerFeature),
                 (:FrameInterval, FloatingPointFeature),
                 (:FrameIntervalTiming, BooleanFeature),
                 (:FrameRate, FloatingPointFeature),
                 (:FullAOIControl, BooleanFeature),
                 (:GateMode, EnumeratedFeature),
                 (:HeatSinkTemperature, FloatingPointFeature),
                 (:IOControl, EnumeratedFeature),
                 (:IODirection, BooleanOrEnumeratedFeature),
                 (:IOInvert, BooleanFeature),
                 (:IOSelector, EnumeratedFeature),
                 (:IOState, BooleanFeature),
                 (:IRPreFlashEnable, BooleanFeature),
                 (:ImageSizeBytes, IntegerFeature),
                 (:InputVoltage, FloatingPointFeature),
                 (:InterfaceType, StringFeature),
                 (:KeepCleanEnable, BooleanFeature),
                 (:KeepCleanPostExposureEnable, BooleanFeature),
                 (:LUTIndex, IntegerFeature),
                 (:LUTValue, IntegerFeature),
                 (:LineScanSpeed, FloatingPointFeature),
                 (:MCPGain, IntegerFeature),
                 (:MCPIntelligate, BooleanFeature),
                 (:MCPVoltage, IntegerFeature),
                 (:MaxInterfaceTransferRate, FloatingPointFeature),
                 (:MetadataEnable, BooleanFeature),
                 (:MetadataFrame, BooleanFeature),
                 (:MetadataTimestamp, BooleanFeature),
                 (:MicrocodeVersion, StringFeature),
                 (:MultitrackBinned, BooleanFeature),
                 (:MultitrackCount, IntegerFeature),
                 (:MultitrackEnd, IntegerFeature),
                 (:MultitrackSelector, IntegerFeature),
                 (:MultitrackStart, IntegerFeature),
                 (:Overlap, BooleanFeature),
                 (:PixelCorrection, EnumeratedFeature),
                 (:PixelEncoding, EnumeratedFeature),
                 (:PixelHeight, FloatingPointFeature),
                 (:PixelReadoutRate, EnumeratedFeature),
                 (:PixelWidth, FloatingPointFeature),
                 (:PortSelector, IntegerFeature),
                 (:PreAmpGain, EnumeratedFeature),
                 (:PreAmpGainChannel, EnumeratedFeature),
                 (:PreAmpGainControl, EnumeratedFeature),
                 (:PreAmpGainSelector, EnumeratedFeature),
                 (:PreAmpGainValue, IntegerFeature),
                 (:PreAmpOffsetValue, IntegerFeature),
                 (:PreTriggerEnabled, BooleanFeature),
                 (:ReadoutTime, FloatingPointFeature),
                 (:RollingShutterGlobalClear, BooleanFeature),
                 (:RowNExposureEndEvent, IntegerFeature),
                 (:RowNExposureStartEvent, IntegerFeature),
                 (:RowReadTime, FloatingPointFeature),
                 (:ScanSpeedControlEnable, BooleanFeature),
                 (:SensorCooling, BooleanFeature),
                 (:SensorHeight, IntegerFeature),
                 (:SensorModel, StringFeature),
                 (:SensorReadoutMode, EnumeratedFeature),
                 (:SensorTemperature, FloatingPointFeature),
                 (:SensorType, EnumeratedFeature),
                 (:SensorWidth, IntegerFeature),
                 (:SerialNumber, StringFeature),
                 (:ShutterAmpControl, BooleanFeature),
                 (:ShutterMode, EnumeratedFeature),
                 (:ShutterOutputMode, EnumeratedFeature),
                 (:ShutterState, BooleanFeature),
                 (:ShutterStrobePeriod, FloatingPointFeature),
                 (:ShutterStrobePosition, FloatingPointFeature),
                 (:ShutterTransferTime, FloatingPointFeature),
                 (:SimplePreAmpGainControl, EnumeratedFeature),
                 (:SoftwareTrigger, CommandFeature),
                 (:SoftwareVersion, StringFeature),
                 (:SpuriousNoiseFilter, BooleanFeature),
                 (:StaticBlemishCorrection, BooleanFeature),
                 (:SynchronousTriggering, BooleanFeature),
                 (:TargetSensorTemperature, FloatingPointFeature),
                 (:TemperatureControl, EnumeratedFeature),
                 (:TemperatureStatus, EnumeratedFeature),
                 (:TimestampClock, IntegerFeature),
                 (:TimestampClockFrequency, IntegerFeature),
                 (:TimestampClockReset, CommandFeature),
                 (:TransmitFrames, BooleanFeature),
                 (:TriggerMode, EnumeratedFeature),
                 (:UsbDeviceId, IntegerFeature),
                 (:UsbProductId, IntegerFeature),
                 (:VerticallyCenterAOI, BooleanFeature), # FIXME: typo?
                 (:VerticallyCentreAOI, BooleanFeature))
    @eval begin
        const $sym = $(T(sym))
        export $sym
    end
end

end # module Features
