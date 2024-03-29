# p6-COGL

## Installation

Make a directory to contain the p6-Gtk-based projects. Once made, then set the P6_GTK_HOME environment variable to that directory:

```
$ export P6_GTK_HOME=/path/to/projects
```

Switch to that directory and clone the dependencies...

```
$ git clone https://github.com/Xliff/p6-GLib.git
$ git clone https://github.com/Xliff/p6-GIO.git
$ git clone https://github.com/Xliff/p6-Pango.git
$ git clone https://github.com/Xliff/p6-GDK.git
$ git clone https://github.com/Xliff/p6-GtkPlus.git
$ git clone https://github.com/Xliff/p6-COGL.git
$ cd p6-GLib
$ sh ./install-prereqs.sh
```

[Optional] To build all of COGL and the required GTK modules, you can change to the p6-COGL directory and do:

```
$ cd p6-COGL
$ ./build.sh
```

If you just want to run the examples, you can do:

```
./p6gtkexec t/<name of example>
```

Unfortunately, compile times are very long for this project, but I hope you find it interesting!
