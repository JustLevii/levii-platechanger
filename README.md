# levii-platechanger
 FiveM basic plate changer ~ ox_lib

![Image](https://cdn.discordapp.com/attachments/781483089264115712/1085236535105961994/image.png)

## Usage

* [Item image download](https://cdn.discordapp.com/attachments/1082006975212163092/1085223302290735164/licenseplate.png)
 
* **ox_inventory > data > items.lua**
```lua 
['licenseplate'] = {
        label = 'License Plate',
        stack = false,
        weight = 100,
        close = true,
        description = "Vehicle license plate",
        client = {
            image = 'license_plate.png',
        }
    },
````
* **qb-inventory or lj-inventory - qb-core > shared > items.lua**
```lua 
['licenseplate']                  = {['name'] = 'licenseplate',                       ['label'] = 'License Plate',             ['weight'] = 100,         ['type'] = 'item',         ['image'] = 'license_plate.png',         ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,  ['description'] = 'Vehicle license plate'},
````

### Dependency
* [ox_lib](https://github.com/overextended/ox_lib)
* [oxmysql](https://github.com/overextended/oxmysql)

### Compatible
* ESX or QBcore


### Support
* [Discord](https://discord.gg/uyuyorum)
