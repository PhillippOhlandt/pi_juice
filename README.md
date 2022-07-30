# PiJuice

![Test Status](https://github.com/PhillippOhlandt/pi_juice/actions/workflows/tests.yml/badge.svg)
![Latest Version](https://img.shields.io/hexpm/v/pi_juice.svg)

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pi_juice` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pi_juice, "~> 0.1.0"}
  ]
end
```

## Features

This library organizes the features a bit differently than the [original library](https://github.com/PiSupply/PiJuice/tree/master/Software#i2c-command-api). 
The following tables show the structure of this library, the mapping to the original library
and the implementation status of each function.

### `PiJuice.Status`

| Function            | Real implementation | Mock implementation | Mock Simulated | Original library         |
|---------------------|---------------------|---------------------|----------------|--------------------------|
| `get_status`        | ❌                   | ❌                   | ❌              | `status.GetStatus`       |
| `get_fault_status`  | ❌                   | ❌                   | ❌              | `status.GetFaultStatus`  |
| `reset_fault_flags` | ❌                   | ❌                   | ❌              | `status.ResetFaultFlags` |

### `PiJuice.Battery`

| Function                     | Real implementation | Mock implementation | Mock Simulated | Original library                    |
|------------------------------|---------------------|---------------------|----------------|-------------------------------------|
| `get_charge_level`           | ❌                   | ❌                   | ❌              | `status.GetChargeLevel`             |
| `get_temperature`            | ❌                   | ❌                   | ❌              | `status.GetBatteryTemperature`      |
| `get_voltage`                | ❌                   | ❌                   | ❌              | `status.GetBatteryVoltage`          |
| `get_current`                | ❌                   | ❌                   | ❌              | `status.GetBatteryCurrent`          |
| `get_charging_config`        | ❌                   | ❌                   | ❌              | `config.GetChargingConfig`          |
| `set_charging_config`        | ❌                   | ❌                   | ❌              | `config.SetChargingConfig`          |
| `profiles`                   | ❌                   | ❌                   | ❌              | `config.SelectBatteryProfiles`      |
| `get_profile`                | ❌                   | ❌                   | ❌              | `config.GetBatteryProfile`          |
| `set_profile`                | ❌                   | ❌                   | ❌              | `config.SetBatteryProfile`          |
| `set_custom_profile`         | ❌                   | ❌                   | ❌              | `config.SetCustomBatteryProfile`    |
| `get_profile_status`         | ❌                   | ❌                   | ❌              | `config.GetBatteryProfileStatus`    |
| `get_ext_profile`            | ❌                   | ❌                   | ❌              | `config.GetBatteryExtProfile`       |
| `set_custom_ext_profile`     | ❌                   | ❌                   | ❌              | `config.SetCustomBatteryExtProfile` |
| `get_temp_sense_config`      | ❌                   | ❌                   | ❌              | `config.GetBatteryTempSenseConfig`  |
| `set_temp_sense_config`      | ❌                   | ❌                   | ❌              | `config.SetBatteryTempSenseConfig`  |
| `get_rsoc_estimation_config` | ❌                   | ❌                   | ❌              | `config.GetRsocEstimationConfig`    |
| `set_rsoc_estimation_config` | ❌                   | ❌                   | ❌              | `config.SetRsocEstimationConfig`    |

### `PiJuice.Power`

| Function                  | Real implementation | Mock implementation | Mock Simulated | Original library               |
|---------------------------|---------------------|---------------------|----------------|--------------------------------|
| `get_power_off`           | ❌                   | ❌                   | ❌              | `power.GetPowerOff`            |
| `set_power_off`           | ❌                   | ❌                   | ❌              | `power.SetPowerOff`            |
| `get_wakeup_on_charge`    | ❌                   | ❌                   | ❌              | `power.GetWakeUpOnCharge`      |
| `set_wakeup_on_charge`    | ❌                   | ❌                   | ❌              | `power.SetWakeUpOnCharge`      |
| `get_watchdog`            | ❌                   | ❌                   | ❌              | `power.GetWatchdog`            |
| `set_watchdog`            | ❌                   | ❌                   | ❌              | `power.SetWatchdog`            |
| `get_system_power_switch` | ❌                   | ❌                   | ❌              | `power.GetSystemPowerSwitch`   |
| `set_system_power_switch` | ❌                   | ❌                   | ❌              | `power.SetSystemPowerSwitch`   |
| `get_input_config`        | ❌                   | ❌                   | ❌              | `config.GetPowerInputsConfig`  |
| `set_input_config`        | ❌                   | ❌                   | ❌              | `config.SetPowerInputsConfig`  |
| `get_regulator_mode`      | ❌                   | ❌                   | ❌              | `config.GetPowerRegulatorMode` |
| `set_regulator_mode`      | ❌                   | ❌                   | ❌              | `config.SetPowerRegulatorMode` |

### `PiJuice.Button`

| Function       | Real implementation | Mock implementation | Mock Simulated | Original library                |
|----------------|---------------------|---------------------|----------------|---------------------------------|
| `get_events`   | ❌                   | ❌                   | ❌              | `status.GetButtonEvents`        |
| `accept_event` | ❌                   | ❌                   | ❌              | `status.AcceptButtonEvent`      |
| `get_config`   | ❌                   | ❌                   | ❌              | `config.GetButtonConfiguration` |
| `set_config`   | ❌                   | ❌                   | ❌              | `config.SetButtonConfiguration` |

### `PiJuice.LED`

| Function     | Real implementation | Mock implementation | Mock Simulated | Original library             |
|--------------|---------------------|---------------------|----------------|------------------------------|
| `get_state`  | ❌                   | ❌                   | ❌              | `status.GetLedState`         |
| `set_state`  | ❌                   | ❌                   | ❌              | `status.SetLedState`         |
| `get_blink`  | ❌                   | ❌                   | ❌              | `status.GetLedBlink`         |
| `set_blink`  | ❌                   | ❌                   | ❌              | `status.SetLedBlink`         |
| `get_config` | ❌                   | ❌                   | ❌              | `config.GetLedConfiguration` |
| `set_config` | ❌                   | ❌                   | ❌              | `config.SetLedConfiguration` |

### `PiJuice.RTC`

| Function             | Real implementation | Mock implementation | Mock Simulated | Original library       |
|----------------------|---------------------|---------------------|----------------|------------------------|
| `get_control_status` | ❌                   | ❌                   | ❌              | `rtc.GetControlStatus` |
| `clear_alarm_flag`   | ❌                   | ❌                   | ❌              | `rtc.ClearAlarmFlag`   |
| `set_wakeup_enabled` | ❌                   | ❌                   | ❌              | `rtc.SetWakeupEnabled` |
| `get_time`           | ❌                   | ❌                   | ❌              | `rtc.GetTime`          |
| `set_time`           | ❌                   | ❌                   | ❌              | `rtc.SetTime`          |
| `get_alarm`          | ❌                   | ❌                   | ❌              | `rtc.GetAlarm`         |
| `set_alarm`          | ❌                   | ❌                   | ❌              | `rtc.SetAlarm`         |

### `PiJuice.IO`

| Function             | Real implementation | Mock implementation | Mock Simulated | Original library            |
|----------------------|---------------------|---------------------|----------------|-----------------------------|
| `get_voltage`        | ❌                   | ❌                   | ❌              | `status.GetIoVoltage`       |
| `get_current`        | ❌                   | ❌                   | ❌              | `status.GetIoCurrent`       |
| `get_digital_input`  | ❌                   | ❌                   | ❌              | `status.GetIoDigitalInput`  |
| `get_digital_output` | ❌                   | ❌                   | ❌              | `status.GetIoDigitalOutput` |
| `set_digital_output` | ❌                   | ❌                   | ❌              | `status.SetIoDigitalOutput` |
| `get_analog_input`   | ❌                   | ❌                   | ❌              | `status.GetIoAnalogInput`   |
| `get_pwm`            | ❌                   | ❌                   | ❌              | `status.GetIoPWM`           |
| `set_pwm`            | ❌                   | ❌                   | ❌              | `status.SetIoPWM`           |
| `get_config`         | ❌                   | ❌                   | ❌              | `config.GetIoConfiguration` |
| `set_config`         | ❌                   | ❌                   | ❌              | `config.SetIoConfiguration` |

### `PiJuice.Firmware`

| Function      | Real implementation | Mock implementation | Mock Simulated | Original library            |
|---------------|---------------------|---------------------|----------------|-----------------------------|
| `get_version` | ❌                   | ❌                   | ❌              | `config.GetFirmwareVersion` |

### `PiJuice.Config`

| Function                      | Real implementation | Mock implementation | Mock Simulated | Original library                 |
|-------------------------------|---------------------|---------------------|----------------|----------------------------------|
| `get_address`                 | ❌                   | ❌                   | ❌              | `config.GetAddress`              |
| `set_address`                 | ❌                   | ❌                   | ❌              | `config.SetAddress`              |
| `get_run_pin_config`          | ❌                   | ❌                   | ❌              | `config.GetRunPinConfig`         |
| `set_run_pin_config`          | ❌                   | ❌                   | ❌              | `config.SetRunPinConfig`         |
| `get_id_eeprom_write_protect` | ❌                   | ❌                   | ❌              | `config.GetIdEepromWriteProtect` |
| `set_id_eeprom_write_protect` | ❌                   | ❌                   | ❌              | `config.SetIdEepromWriteProtect` |
| `get_id_eeprom_address`       | ❌                   | ❌                   | ❌              | `config.GetIdEepromAddress`      |
| `set_id_eeprom_address`       | ❌                   | ❌                   | ❌              | `config.SetIdEepromAddress`      |
| `set_default_config`          | ❌                   | ❌                   | ❌              | `config.SetDefaultConfiguration` |
| `run_test_calibration`        | ❌                   | ❌                   | ❌              | `config.RunTestCalibration`      |

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/pi_juice](https://hexdocs.pm/pi_juice).

