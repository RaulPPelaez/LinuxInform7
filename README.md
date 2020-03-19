## Inform7 for linux

install_i7.sh:  
	Downloads and installs Inform7 to the home folder of any OS that can run the generic x86 Linux build in http://inform7.com/downloads/  

build.sh:  
	Build and release to a webpage with an interpreter any valid Inform7 story.ni file. It can only compile stories that consist of a single story.ni file (although build.sh can be modified easily to support a full standard inform.project folder), it will ignore anything else.  
	All output coming from i7 will be placed in compilation.log.  
	Compilation errors will be thrown to stderr.  
	
## USAGE

```bash
$ git clone https://github.com/raulppelaez/inform7InLinux
#Install inform7, only run the first time
$ bash LinuxInform7/install_i7.sh
$ bash LinuxInform7/build.sh my_story.ni
$ firefox my_story.release/play.html
```
	
	
	
