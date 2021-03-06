/datum/power/changeling/fleshmend
	name = "Fleshmend"
	desc = "Begins a slow rengeration of our form.  Does not effect stuns or chemicals."
	helptext = "Can be used while unconscious."
	enhancedtext = "Healing is twice as effective."
	genomecost = 1
	verbpath = /mob/living/proc/changeling_fleshmend

//Starts healing you every second for 50 seconds. Can be used whilst unconscious.
/mob/living/proc/changeling_fleshmend()
	set category = "Changeling"
	set name = "Fleshmend (10)"
	set desc = "Begins a slow rengeration of our form.  Does not effect stuns or chemicals."

	var/datum/changeling/changeling = changeling_power(10,0,100,UNCONSCIOUS)
	if(!changeling)
		return 0
	src.mind.changeling.chem_charges -= 10

	var/mob/living/carbon/human/C = src
	var/heal_amount = 2
	if(src.mind.changeling.recursive_enhancement)
		heal_amount = heal_amount * 2
		src << SPAN_NOTE("We will heal much faster.")
		src.mind.changeling.recursive_enhancement = 0

	spawn(0)
		src << SPAN_NOTE("We begin to heal ourselves.")
		for(var/i = 0, i<50,i++)
			if(C)
				C.adjustBruteLoss(-heal_amount)
				C.adjustOxyLoss(-heal_amount)
				C.adjustFireLoss(-heal_amount)
				sleep(1 SECOND)

	src.verbs -= /mob/living/proc/changeling_fleshmend
	spawn(50 SECONDS)
		src << SPAN_NOTE("Our regeneration has slowed to normal levels.")
		src.verbs |= /mob/living/proc/changeling_fleshmend
	return 1