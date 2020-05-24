#!/usr/bin/with-contenv sh


#create filebot destination dir
mkdir -p /downloads/media /data/filebot /data/scripts

echo "Configuration of filebot... "

# Externalize filebot data folder
if [ -d /data/filebot/data ]; then
	echo "    Re-use existing Filebot data directory... "
	rm -rf /filebot/data
	ln -s /data/filebot/data /filebot/data
else
	echo "    New Filebot data directory..."
	mkdir -p /data/filebot/data
	rm -rf /filebot/data
	ln -s /data/filebot/data /filebot/data
fi

# Add license file
ls ${FILEBOT_LICENSE}
if [ ! -e "${FILEBOT_LICENSE}" ]; then
	echo "    License filebot file does not exist!!"
	exit 1
elif [ ! -e /filebot/data/.license ]; then
    echo "    Need to apply License filebot file does not exist!!"
	/filebot/filebot.sh --license "${FILEBOT_LICENSE}"
elif [ -e /filebot/data/.license ]; then
	echo "    Filebot already registered"
fi

echo "    Change Filebot permission (/downloads/media & /data/filebot & /filebot)to rtorrent"
chown -R rtorrent. /downloads/media /data/filebot /filebot

#chmod +x /usr/local/bin/postdl /usr/local/bin/postrm
echo "Filebot configuration done" # success of Configuration of filebot

echo "Fix permission of /data/scripts"
chown -R rtorrent. /data/scripts

