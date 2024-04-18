```
			███╗   ███╗ ██████╗██╗  ██╗██████╗             
			████╗ ████║██╔════╝██║  ██║██╔══██╗            
			██╔████╔██║██║     ███████║██████╔╝            
			██║╚██╔╝██║██║     ██╔══██║██╔═══╝             
			██║ ╚═╝ ██║╚██████╗██║  ██║██║                 
			╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝                 
                                               
		 ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
		██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
		██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
		██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
		╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
		 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
```
- - - - - - - - - - - - - - - - - - - - 
## MCHP CONFIG - Configured, Patched, and Updated Versions of the [MITRE Caldera Human Plugin](https://github.com/mitre/human)

The install script can be run via:
```
bash MCHP_CONFIGS/install_reqs.sh --config_flags_here
```

### BROWSER COMPATABILITY (flags)
Chrome:
```
--linux64_chrome
```

Firefox:
```
--linux64_firefox
--armv7_firefox
```

### DEFAULT 
The Default configuration is a mostly stock, sightly tuned variation of the MCHP Plugin
```
--default
```

### SLEEPY 
The Default configuration behaviorh, but set to goto sleep between 10PM - 4AM, and sleep for anywhere between 4-10 hours.
```
--sleepy
```

### DOPEY
The Default configuration behaviorh, but set to sleep between groups of tasks for anywhere from 0 to 60 minutes at any time.
```
--dopey
```

### DOC
The Sleepy configuration of behaviorh, with the google searches augmented by a [NanoGPT](https://github.com/karpathy/nanoGPT) (torch CPU ONLY) mini-ai.
```
--doc
```

## QUICKSTART DEPLOYMENTS: 
Linux64 w/Chrome Default:
```
bash MCHP_CONFIGS/install_reqs.sh --linux64_chrome --default
```

Raspberry Pi 5 w/Firefox Sleepy:
```
bash MCHP_CONFIGS/install_reqs.sh --armv7_firefox --default
```

Linux64 w/Firefox Doc:
```
bash MCHP_CONFIGS/install_reqs.sh --linux64_firefox --doc
```

Linux64 w/Firefox Dopey:
```
bash MCHP_CONFIGS/install_reqs.sh --linux64_firefox --dopey
```