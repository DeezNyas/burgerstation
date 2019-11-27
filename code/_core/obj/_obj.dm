/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	layer = LAYER_OBJ
	plane = PLANE_OBJ

	var/should_save = TRUE

/obj/Destroy()
	if(loc)
		drop_item()
	loc = null
	return ..()

/obj/proc/on_spawn() //When the object is spawned by a spawnpoint
	return