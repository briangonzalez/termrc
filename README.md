<img src="https://rawgithub.com/briangonzalez/termrc/master/images/osx.svg" width=25 style="margin-right: 10px"> termrc
======
Take your [iTerm2](http://www.iterm2.com/) environments with you wherever you go.

Description
-----------
Termrc allows you to store information about your project's environment for a given project in a small YAML file called a `Termfile` file. Restoring your project's environment is as simple as calling `termrc start`. Enjoy.

Quick Start
-----------
```bash
$ gem install termrc
$ termrc create
$ termrc start
```

The Termfile
------------
The `Termfile` file is a [YAML](http://en.wikipedia.org/wiki/YAML) file which stores information about your project's environment. An environment, in this context, is an iTerm2 window with various panes, each with a different default command that is run when the pane opens. The `layout` dictates what your window looks like, while `commands` gives you a set of commands you can call for each pane.

Place the `Termfile` file at your project's root, then call `termrc start`. Voila!

**Example Termfile**

```yaml
commands:
  here:       echo "Hello, here."
  there:      echo "Hello, there."
  world:      echo "Hello, world."
  me:         echo "Hello, me."
  you:        echo "Hello, you."

layout:
  - [ here, there ]       # row 1, with 2 panes
  - [ world ]             # row 2, with 1 pane
  - [ me, you ]           # row 3, with 2 panes
```

**The Result**

A `Termfile` file is a YAML file which requires two keys: `commands` and a `layout`. Each item in `layout` corresponds to a row of panes in iTerm2. So, for instance, the example `Termfile` file above would produce a new iTerm2 window with the following commands running inside each pane:

<img src="https://rawgithub.com/briangonzalez/termrc/master/images/termrc-screen.png">

You can supply an optional key, `root`, which indicates the root directory you'd like each command to be run inside of. Have a look at [this project's Termfile](https://github.com/briangonzalez/termrc/blob/master/Termfile.test) for an example.

You can also supply a `layout_type` value, either `row` or `column`, which denotes whether to use rows or columns as the means for splitting the window. This defaults to `layout_type: row`.

**Tabs**

You can automate tabs by providing an array of arrays, each array denoting a new tab and the layout within it. See [this template file](https://github.com/briangonzalez/termrc/blob/master/lib/template/termfile_with_tabs.template) for an example.

** Windows **

You can also use termrc to open multiple windows [like so](https://github.com/briangonzalez/termrc/blob/master/lib/template/termfile_with_multiple_windows.template).

CLI
---

```bash
$ termrc start      # Start termrc file (Shortcut: s, Argument 0: file (optional) )
$ termrc create     # Create termrc file
$ termrc list       # List termrc files in folder (Shortcut: l, Argument 0: folder (optional))
```


License
--------
Released under the MIT License.

Questions?
----------
| ![twitter/brianmgonzalez](http://gravatar.com/avatar/f6363fe1d9aadb1c3f07ba7867f0e854?s=70](http://twitter.com/brianmgonzalez "Follow @brianmgonzalez on Twitter") |
|---|
| [Brian Gonzalez](http://briangonzalez.org) |

Changelog
---------
* March 19, 2014 - Now using `Termfile`; panes now named with given command

Resources
---------
- [iTerm2 - Scripting with Applescript](https://code.google.com/p/iterm2/wiki/AppleScript)
- [iTerm2 - Working with panes](https://code.google.com/p/iterm2/issues/detail?id=559)
