var/global/list/obj/item/radio/all_radios = list()

/obj/item/radio/
	name = "radio"
	desc = "Long distance communication in the realm. What could possibly go wrong?"
	icon = 'icons/obj/items/radio.dmi'

	var/frequency = RADIO_FREQ_COMMON //The frequency of the radio.
	var/receiving = TRUE //Whether or not the radio can recieve messages.
	var/broadcasting = TRUE //Whether or not the radio can broadcast messages without having to press the button.

	var/radio_sound = 'sounds/items/radio.ogg'

/obj/item/radio/click_self(var/mob/caller,location,control,params)

	receiving = !receiving

	caller.to_chat(span("notice","You toggle the reciever to [receiving ? "always broadcast." : "only broadcast when pressed."]"))

	return TRUE

/obj/item/radio/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_inventory(object))
		return ..()

	broadcasting = !broadcasting
	caller.to_chat(span("notice","You toggle the speaker [broadcasting ? "on" : "off"]."))

	return TRUE

/obj/item/radio/on_mouse_wheel(caller,delta_x,delta_y,location,control,params)
	world.log << delta_y
	return TRUE

/obj/item/radio/New(var/desired_loc)
	all_radios += src
	return ..()

/obj/item/radio/destroy()
	all_radios -= src
	return ..()

//Radio Data Format
/*

list(
	"speaker" = mob,
	"message" = text,
	"time" = time as time of day
	"source" = mob or radio
	"frequency" = number of the radio frequency
)
*/

/obj/item/radio/proc/send_data(var/list/data = list())

	if(!length(data))
		return FALSE

	if(!data["frequency"])
		data["frequency"] = frequency

	var/speaker_ref = "/ref[data["speaker"]]"

	if(all_unprocessed_radio_data[speaker_ref])
		return FALSE

	all_unprocessed_radio_data[speaker_ref] = data

	var/turf/current_turf = get_turf(src)

	play_sound(radio_sound,all_mobs_with_clients,vector(current_turf.x,current_turf.y,current_turf.z))

	return TRUE

/obj/item/radio/proc/recieve_data(var/list/data = list())

	if(!length(data))
		return FALSE

	if(data["frequency"] != frequency)
		return FALSE

	display_message(data["speaker"],src,data["message"],TEXT_RADIO)

	return TRUE