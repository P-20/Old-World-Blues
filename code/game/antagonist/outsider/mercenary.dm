var/datum/antagonist/mercenary/mercs

/datum/antagonist/mercenary
	id = ROLE_MERCENARY
	role_text = "Nuclear Operative"
	bantype = "operative"
	antag_indicator = "synd"
	role_text_plural = "Nuclear Operatives"
	landmark_id = "Syndicate-Spawn"
	leader_welcome_text = "You are the leader of the Syndicate operatives; hail to the chief. Use :t to speak to your underlings."
	welcome_text = "You are a Syndicate operative! To speak on the strike team's private channel use :t."
	flags = ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_HAS_NUKE | ANTAG_SET_APPEARANCE | ANTAG_HAS_LEADER
	id_type = /obj/item/weapon/card/id/syndicate
	antaghud_indicator = "hudoperative"

	hard_cap = 4
	hard_cap_round = 8
	initial_spawn_req = 4
	initial_spawn_target = 6

/datum/antagonist/mercenary/New()
	..()
	mercs = src

/datum/antagonist/mercenary/create_global_objectives()
	if(!..())
		return 0
	global_objectives = list(new /datum/objective/nuclear)
	return 1

/datum/antagonist/mercenary/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	player.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/black/swat(player), slot_gloves)
	switch(player.backbag)
		if(2) player.equip_to_slot_or_del(new /obj/item/storage/backpack(player), slot_back)
		if(3) player.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(player), slot_back)
		if(4) player.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(player), slot_back)
		if(5) player.equip_to_slot_or_del(new /obj/item/storage/backpack/dufflebag(player), slot_back)
		if(6) player.equip_to_slot_or_del(new /obj/item/storage/backpack/messenger(player), slot_back)
	player.equip_to_slot_or_del(new /obj/item/storage/box/engineer(player.back), slot_in_backpack)
	player.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/pill/cyanide(player), slot_in_backpack)

	if (player.mind == leader)
		var/obj/item/device/radio/uplink/U = new(player.loc)
		U.hidden_uplink.uplink_owner = player.mind
		U.hidden_uplink.uses = 40
		player.put_in_hands(U)

	player.equip_survival_gear()
	player.update_icons()

	create_id("Mercenary", player)
	create_radio(SYND_FREQ, player)
	//Some music
	player << sound('sound/misc/syndicate_intro.ogg', repeat = 0, wait = 0, volume = 85, channel = 777)
	return 1
