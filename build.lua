#!/usr/bin/env lua

--------------
-- Settings --
--------------

-- Set this to true to use a better compression algorithm for the sound driver.
-- Having this set to false will use an inferior compression algorithm that
-- results in an accurate ROM being produced.
local improved_sound_driver_compression = true

---------------------
-- End of settings --
---------------------

local common = require "build_tools.lua.common"

local compression = improved_sound_driver_compression and "kosinski-optimised" or "kosinski"
local success, continue = common.build_rom("sonic3k", "s3unlocked", "", "-p=FF -z=0," .. compression .. ",Size_of_Snd_driver_guess,before", false, "https://github.com/sonicretro/skdisasm")

if not success then
	exit_code = false
end

if not continue then
	os.exit(false)
end

-- Correct the ROM's header with a proper checksum and end-of-ROM value.
common.fix_header("s3unlocked.bin")

os.exit(exit_code)
