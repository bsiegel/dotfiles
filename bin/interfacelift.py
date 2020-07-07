#!/usr/bin/env python
import os, urllib2, re, sys, commands, random, time, glob

# -- Changable Variables
urls            = ['http://interfacelift.com/wallpaper/downloads/date/widescreen/2880x1800/',
                   'http://interfacelift.com/wallpaper/downloads/date/widescreen/2560x1600/',
                   'http://interfacelift.com/wallpaper/downloads/date/widescreen/1920x1200/']
directory       = '/Users/brsiegel/Pictures/interfacelift' #Path to download to
wgetpath        = '/usr/local/bin/wget' #Default on linux systems /usr/local/bin/wget on freebsd
backfill        = False

# -- Should not need to edit below here unless something stops working --
useragent       = 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 (.NET CLR 3.5.30729)' #Fake useragent since wget is blocked
pattern         = '(?<=<a href=")/wallpaper/.*jpg(?=">)' # The regex pattern used to look up picture url paths
picturepattern  = '[^/]*$' # The regex pattern to pull picture filename to see if file exists

for url in urls:
        print 'Downloading images from %s:' % url
        totalwallpapercount = 0
        wallpapercount = 0
        count = 1
        while count < 999999:
                print 'Scanning page %s' % count
                headers    = { 'User-Agent' : useragent }
                request    = urllib2.Request(url + "index" + str(count) + ".html", None, headers)
                data       = urllib2.urlopen(request).read()
                pictures   = re.findall(pattern, data)
                urlcount   = len(pictures)
                for picture in pictures:
                        m = re.search(picturepattern, picture)
                        picturefile=m.group()
                        if len(glob.glob(directory + '/%s*.jpg' % picturefile[0:5])) == 0:
                                status, output = commands.getstatusoutput(wgetpath + ' -P ' + directory + ' --random-wait -nc -U "' + useragent + '" ' + 'http://interfacelift.com' + picture)
                                if status == 0:
                                        print str(totalwallpapercount) + '. Downloaded http://interfacelift.com' + picture + ' ...'
                                else:
                                        print str(totalwallpapercount) + '. DOWNLOAD FAILED check wget output below for reason.'
                                        print output
                                        print 'Exiting script ... wget returned non 0 exit status code: ' + str(status)
                                        quit()
                                wallpapercount += 1
                                totalwallpapercount += 1
                if urlcount == 0 or (not backfill and wallpapercount == 0):
                        print "Downloaded " + str(totalwallpapercount) + " wallpaper from InterfaceLift at this resolution."
                        break
                count += 1
                if wallpapercount > 0 or count % 10 == 0:
                        wallpapercount = 0
                        randomnum  = random.randint(5,15)
                        print 'Sleeping for :' + str(randomnum)
                        #time.sleep(randomnum)

