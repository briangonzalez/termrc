
termrc
======
Keep your iTerm2 environments with you wherever you go.

Description
-----------
Termrc allows you to store information about your project's environment for a given project in a small YAML file called a `.termrc` file. Restoring your project's environment is as simple as calling `termrc start`. Enjoy.

Installation
------------
```bash
$ gem install termrc
$ termrc create 
$ termrc start
```

.termrc file
----------
The `.termrc` file is a [YAML](http://en.wikipedia.org/wiki/YAML) file which stores information about your project's environment. An environment, in this context, is an iTerm2 window with various panes each with a different default command.   

**Example .termrc**

```yaml
commands:
  here:       echo "1"
  there:      echo "2"
  me:         echo "4"
  you:        echo "5"
  world:      echo "3"

layout:
  - [ 'here', 'there' ]       # row 1, with 2 panes
  - [ 'world' ]               # row 2, with 1 pane
  - [ 'me', 'you' ]           # row 3, with 2 panes
``` 

A `.termrc` file is a YAML file which requires two keys: `commands` and a `layout`. Each item in `layout` corresponds to a row of panes in iTerm2. So, for instance, the example `.termrc` file above would produce a new iTerm2 window with the following commands running inside each pane:

```
-----------------------
| echo "1" | echo "2" |
|---------------------|
|      echo "3"       |
|---------------------|
| echo "4" | echo "5" |
-----------------------
```

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