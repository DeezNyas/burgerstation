/savedata/client/
	var/client/owner

/savedata/client/get_folder(var/folder_id)
	return replacetext(CKEY_PATH_FORMAT,"%CKEY",folder_id)

/savedata/client/get_files()
	return flist(get_folder(owner.ckey))