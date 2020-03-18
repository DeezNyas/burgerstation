/obj/item/analyzer
	name = "analyzer"
	var/next_scan = 0

/obj/item/analyzer/proc/on_scan(var/mob/caller,var/atom/target)

	if(next_scan >= world.time)
		caller.to_chat("\The [src.name] is recharging, please wait!")
		return FALSE

	return TRUE

/obj/item/analyzer/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)
	on_scan(caller,object)
	return TRUE
