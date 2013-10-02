
<img src="https://rawgithub.com/briangonzalez/termrc/master/images/osx.svg" width=25 style="margin-right: 10px"> termrc
======
Take your [iTerm2](http://www.iterm2.com/) environments with you wherever you go.

Description
-----------
Termrc allows you to store information about your project's environment for a given project in a small YAML file called a `.termrc` file. Restoring your project's environment is as simple as calling `termrc start`. Enjoy.

Quick Start
-----------
```bash
$ gem install termrc
$ termrc create 
$ termrc start
```

.termrc file
----------
The `.termrc` file is a [YAML](http://en.wikipedia.org/wiki/YAML) file which stores information about your project's environment. An environment, in this context, is an iTerm2 window with various panes, each with a different default command that is run when the pane opens. The `layout` dictates what your window looks like, while `commands` gives you a set of commands you can call for each pane.

**Example .termrc**

```yaml
commands:
  here:       echo "Hello, here."
  there:      echo "Hello, there."
  world:      echo "Hello, world."
  me:         echo "Hello, me."
  you:        echo "Hello, you."

layout:
  - [ 'here', 'there' ]       # row 1, with 2 panes
  - [ 'world' ]               # row 2, with 1 pane
  - [ 'me', 'you' ]           # row 3, with 2 panes
``` 

**The Result**

A `.termrc` file is a YAML file which requires two keys: `commands` and a `layout`. Each item in `layout` corresponds to a row of panes in iTerm2. So, for instance, the example `.termrc` file above would produce a new iTerm2 window with the following commands running inside each pane:

<img src="https://rawgithub.com/briangonzalez/termrc/master/images/termrc-screen.png">

You can supply an optional third key, `root`, which indicates the root directory you'd like each command to be run inside of.

License
--------
Released under the MIT License.

Questions?
----------
Find me on [Twitter](http://twitter.com/brianmgonzalez).

Resources
---------
- [iTerm2 - Scripting with Applescript](https://code.google.com/p/iterm2/wiki/AppleScript)
- [iTerm2 - Working with panes](https://code.google.com/p/iterm2/issues/detail?id=559)