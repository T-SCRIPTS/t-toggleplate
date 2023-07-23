local LastVehicle = nil
local LicencePlate = {}
LicencePlate.Index = false
LicencePlate.Number = false

RegisterCommand("irroitakilpi", function()

    if not LicencePlate.Index and not LicencePlate.Number then

        local PlayerPed = PlayerPedId()

        local Coords = GetEntityCoords(PlayerPed)

        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)

        local VehicleCoords = GetEntityCoords(Vehicle)

        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)

        if Distance < 3.5 and not IsPedInAnyVehicle(PlayerPed, false) then
			LastVehicle = Vehicle
            lib.progressCircle({
                duration = 10000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'mini@repair',
                    clip = 'fixing_a_player' 

                },
            })

            LicencePlate.Index = GetVehicleNumberPlateTextIndex(Vehicle)

            LicencePlate.Number = GetVehicleNumberPlateText(Vehicle)

            SetVehicleNumberPlateText(Vehicle, " ")
        else
			lib.notify({
                icon = 'car',
                description = 'Sinun lähelläsi ei ole ajoneuvoja!',
                type = 'error'
            })
        end
    else
        lib.notify({
            icon = 'car',
            description = 'Sinulla ei ole rekisterikilpeä!',
            type = 'error'
        })
    end
end)

RegisterCommand("asennakilpi", function()
    if LicencePlate.Index and LicencePlate.Number then

        local PlayerPed = PlayerPedId()

        local Coords = GetEntityCoords(PlayerPed)

        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)

        local VehicleCoords = GetEntityCoords(Vehicle)

        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)

        if ( (Distance < 3.5) and not IsPedInAnyVehicle(PlayerPed, false) ) then
		if (Vehicle == LastVehicle) then
				LastVehicle = nil
                lib.progressCircle({
                    duration = 10000,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                    anim = {
                        dict = 'mini@repair',
                        clip = 'fixing_a_player' 
    
                    },
                })
			SetVehicleNumberPlateTextIndex(Vehicle, LicencePlate.Index)

			SetVehicleNumberPlateText(Vehicle, LicencePlate.Number)

			LicencePlate.Index = false
			LicencePlate.Number = false
		else
            lib.notify({
                icon = 'car',
                description = 'Tämä ei kuulu tähän!',
                type = 'error'
            })
		end
        else
			lib.notify({
                icon = 'car',
                description = 'Sinun lähelläsi ei ole ajoneuvoja!',
                type = 'error'
            })
        end
    else
        lib.notify({
            icon = 'car',
            description = 'Sinulla ei ole rekisterikilpeä!',
            type = 'error'
        })
    end
end)
