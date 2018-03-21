# kivy-docker-buildozer-android
Docker environment to quickly get an apk from a kivy project

# Dependencies

* sudo apt-get install docker.io docker-compose

# How can I use it?

* Put the kivy project in the project directory, with a buildozer.spec in it.
* run `sudo docker-compose up --build`.

# An example

Using an example from the kivy source code:

```bash
mkdir -p project
wget https://raw.githubusercontent.com/kivy/kivy/master/examples/settings/main.py -O project/main.py
wget https://raw.githubusercontent.com/kivy/kivy/master/examples/settings/android.txt -O project/android.txt

cat <<EOF > project/buildozer.spec
[app]
title = Settings
package.name = settings
package.domain = org.settings
source.dir = .
version = 1.1.0
orientation = all
fullscreen = 0
requirements = kivy
EOF

sudo docker-compose up --build
```

Then, the apk should be in the project/bin directory. Buildozer may fail to move
it in here (it happens with some versions of buildozer). Yet the apk was
generated, but not copied in the project/bin directory. In that case simply run
```find project -name '*apk'``` to find out where you apk is hiding.
