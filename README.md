# LgHS chat mattermost migration

## Description

This repository aims at gathering all the needed pieces used to (1) upgrade the old Rocket.Chat stack and (2) migrate to Mattermost at [LgHS](https://lghs.be/), the hackerspace from [Liege](https://en.wikipedia.org/wiki/Li%C3%A8ge).

As the LgHS is a French speaking non-profit organization, the documentation has been written in French. This was also a mandatory requirement as the latter is actually upstreamed to the [BookStack instance](https://wiki.lghs.be/) used by the hackerspace where all the internal processes and the technical infrastructure is documented.

In practise, this repository gathers the following pieces:
* the documentation explaining the upgrade process from an old Rocket.Chat instance to the latest version, the problems we faced and how we resolved them
* the Docker Compose recipes used on the servers
* the configuration files and patches used during the migration process (e.g. NGINX configuration)
* the code used to import data from Rocket.Chat to Mattermost with the ultimate goal of upstreaming this work to the Mattermost code base.

## Screenshots

Most of the screenshots have been taken using the free hand tool on KDE meaning their size was not identical everywhere, sometimes 2559x1360, sometimes 2559x1358, etc.

We truncated everything to 2559x1355 from the bottom of the images using the following trick from ImageMagick :

```
mogrify -crop 2559x1355+0+0 -gravity South *.png
```

([src.](https://imagemagick.org/Usage/crop), chapter named `Crop relative to Gravity`.)

## License

The code and processes available in this repository are all licensed under the MIT license (cf. license statement in the LICENSE file).