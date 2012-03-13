Rigel
=====

This is the outer repo for the Rigel toolset.
It acts a container repo where cross-tool files, documents, and scripts live.
By default, the other Rigel repositories are checked out to 
the root working directory for of the rigel repo.

The other repositories are:

* [rigel-codegen](https://github.com/rigelproject/rigel-codegen)
* [rigel-targetcode](https://github.com/rigelproject/rigel-targetcode)
* [rigel-sim](https://github.com/rigelproject/rigel-sim)

Organization
------------

### ./scripts

Useful scripts for working with the Rigel tools.

### ./doc

### ./install

By default, an install folder will be placed within the root of this repo. 
This folder is .gitignored

### ./build

By default, a build folder will be placed within the root of this repo. 
This folder is .gitignored

### ./sim

The Rigel simulator repo checks out here by default. 
This folder is .gitignored by the rigel repo.
See the sim repo README for more information.

### ./codegen

Code generation tools for Rigel (GNU binutils, LLVM compiler, etc.)
are checked out here by default.
This folder is .gitignored by the rigel repo.
See the codegen repo README for more information.

### ./targetcode

Source code that runs on the Rigel architecture, including libraries,
headers, test code, and application/benchmark code.
This folder is .gitignored by the rigel repo.
The targetcode repo checks out here by default.
See the targetcode repo README for more information.
