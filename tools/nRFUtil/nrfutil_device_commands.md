# nRFUtil Device Command

`nrfutil device [OPTIONS-DEVICE] [COMMAND] [OPTIONS-COMMAND]`

## nRF5340 Memory Regions

| Region | Description                                 | Range                     |
| :----- | :------------------------------------------ | :------------------------ |
| Flash  | Code                                        | 0x0000 0000 - 0x0010 0000 |
| FICR   | Factory Information Configuration Registers | 0x00FF 0000 - 0x00FF 0C20 |
| UICR   | User Information Configuration Registers    | 0x00FF 8000 - 0x00FF 8800 |
| XIP    | External                                    | 0x1000 0000 - 0x0080 0000 |
| RAM    | RAM                                         | 0x2000 0000 - 0x2008 0000 |

## Device Options

### x-ext-mem-config-file

`nrfutil device --x-ext-mem-config-file [PATH] [COMMAND] [OPTIONS-COMMAND]`

#### Config File Options

The configuration file uses JSON format and includes the fields listed in the following table.

| Field                      | Description                       | Value     |
| :------------------------- | :-------------------------------- | :-------- |
| firmware_config.peripheral | Interface Type:                   | QSPI      |
|                            | QSPI, SPIM0, SPIM3, SPIM00        |           |
| pins.sck                   | Clock pin number:                 | 17        |
| pins.csn                   | Chip select pin number:           | 18        |
| pins.io0                   | Data line 0 pin number:           | 13        |
| pins.io1                   | Data line 1 pin number:           | 14        |
| pins.io2                   | Data line 2 pin number:           | 15        |
| pins.io3                   | Data line 3 pin number:           | 16        |
| flash_size                 | Size of external memory in bytes: | 8388608   |
| page_size                  | Size of memory page in bytes:     | 4096      |
| sck_frequency              | Clock pin frequency:              | 8000000   |
| address_mode               | Addressing mode for memory:       | MODE24BIT |
|                            | MODE24BIT, MODE32BIT              |           |
| readoc                     | Read operation code: FASTREAD,    | READ4IO   |
|                            | READ2O, READ2IO, READ4O, READ4IO  |           |
| writeoc                    | Write operation code:             | PP4IO     |
|                            | PP, PP2O, PP4O, PP4IO             |           |
| pp_size                    | Page program size:                | PPSIZE256 |
|                            | PPSIZE256, PPSIZE512              |           |
| sck_delay                  | Clock delay cycles:   0 - 255     | 0         |
| rx_delay                   | Receive delay cycles: 0 -   7     | 2         |

#### Config File Example

```json
{
    "firmware_config": {
        "peripheral": "QSPI"
    },
    "pins": {
        "sck": 17,
        "csn": 18,
        "io0": 13,
        "io1": 14,
        "io2": 15,
        "io3": 16
    },
    "flash_size": 8388608,
    "page_size": 4096,
    "sck_frequency": 8000000,
    "address_mode": "MODE24BIT",
    "readoc": "READ4IO",
    "writeoc": "PP4IO",
    "pp_size": "PPSIZE256",
    "sck_delay": 0,
    "rx_delay": 2
}
```

## Commands

### program

`nrfutil device [OPTIONS-DEVICE] program --firmware [PATH]`

#### program batch JSON

```json
{
  "core": "NRFDL_DEVICE_CORE_APPLICATION",
  "operation": {
    "type": "program",
    "firmware": {
      "file": "PATH"
    }
  }
}
```

### erase

`nrfutil device [OPTIONS-DEVICE] erase --pages [START_ADDRESS-END_ADDRESS]`

#### erase batch JSON

```json
{
  "core": "NRFDL_DEVICE_CORE_APPLICATION",
  "operation": {
    "type": "erase",
    "option": {
      "chip_erase_mode": "ERASE_PAGES",
      "ext_mem_erase_mode": "ERASE_NONE"
    },
    "pages": {
      "start": ADDRESS-BYTES,
      "end": ADDRESS-BYTES
    }
  }
}
```

### x-read

`nrfutil device [OPTIONS-DEVICE] x-read --width 32 --address [ADDRESS] --bytes [BYTES]`

#### x-read batch JSON

```json
{
  "core": "NRFDL_DEVICE_CORE_APPLICATION",
  "operation": {
    "type": "memory-read",
    "address": "ADDRESS",
    "direct": false,
    "n": BYTES,
    "width": WIDTH
  }
}
```

### x-write

`nrfutil device [OPTIONS-DEVICE] x-write --address [ADDRESS] --value [VALUE]`

#### x-write batch JSON

```json
{
  "core": "NRFDL_DEVICE_CORE_APPLICATION",
  "operation": {
    "type": "memory-write",
    "address": "ADDRESS",
    "data": [
      VALUE-BYTE,
      VALUE-BYTE,
      VALUE-BYTE,
      VALUE-BYTE
    ],
    "direct": false
  }
}
```

### x-filedump

`nrfutil device [OPTIONS-DEVICE] x-filedump [OPTIONS-COMMAND] [PATH]`

#### Command Options

`--code`
Include the code / flash memory region.

`--ficr`
Include the factory information configuration registers memory region.

`--uicr`
Include the user information configuration registers memory region.

`--external`
Include external / XIP memory regions.

`--ram`
Include RAM contents.

#### x-filedump batch JSON

```json
{
  "core": "NRFDL_DEVICE_CORE_APPLICATION",
  "operation": {
    "type": "read-to-file",
    "memory_types": [
      "OPTIONS-COMMAND"
    ],
    "output_file": {
      "Exact": "PATH"
    }
  }
}
```

### x-execute-batch

`nrfutil device [OPTIONS-DEVICE] x-execute-batch --batch-path [PATH]`

#### JSON Batch File Options

| operation.type | Description                 |
| :------------- | :-------------------------- |
| program        | Program firmware on devices |
| erase          | Erase firmware on devices   |
| memory-read    | Read memory from devices    |
| memory-write   | Write to device memory      |
| read-to-file   | Dump device memory to file  |

| Operation program                    | Description                              | Value         |
| :----------------------------------- | :--------------------------------------- | :------------ |
| operation.firmware.file              | Path to firmware file                    | PATH          |

| Operation erase                      | Description                              | Value         |
| :----------------------------------- | :--------------------------------------- | :------------ |
| operation.option.chip_erase_mode     | Erase the flash pages                    | ERASE_PAGES   |
| operation.option.ext_mem_erase_mode  | Control how external memory is erased    | ERASE_NONE    |
| operation.pages.start                | Starting flash page                      | ADDRESS-BYTES |
| operation.pages.end                  | Ending flash page (not included)         | ADDRESS-BYTES |

| Operation memory-read                | Description                              | Value         |
| :----------------------------------- | :--------------------------------------- | :------------ |
| operation.address                    | Start address                            | ADDRESS-HEX   |
| operation.direct                     | Skip memory controller & read directly   | BOOL          |
| operation.n                          | Number of bytes to read                  | BYTES         |
| operation.width                      | Word width                               | 32            |

| Operation memory-write               | Description                              | Value         |
| :----------------------------------- | :--------------------------------------- | :------------ |
| operation.address                    | Address                                  | ADDRESS-HEX   |
| operation.data                       | 32 bit word to write to the address      | BYTE[4]       |
| operation.direct                     | Skip memory controller & write directly  | BOOL          |

| Operation read-to-file               | Description                              | Value         |
| :----------------------------------- | :--------------------------------------- | :------------ |
|operation.memory_types                | Memory regions to include                | String[]      |
|operation.output_file.Exact           | Path to the output file                  | PATH          |

#### JSON Batch File Example

```json
{
  "nrfutil_device_version": "2.8.6",
  "operations": [
    {
      "core": "NRFDL_DEVICE_CORE_APPLICATION",
      "operation": {}
    },
    {
      "core": "NRFDL_DEVICE_CORE_APPLICATION",
      "operation": {}
    }
  ]
}
```
