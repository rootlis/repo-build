set -euo pipefail
readlink -e ./update-one.sh
SCRIPT_PATH=/zfs/build/repo-build/pkgctl-version/update-one.sh
++ [1774029284.188142] [3700573:update-one.sh:4] dirname /zfs/build/repo-build/pkgctl-version/update-one.sh
+ [1774029284.189524] [3700573:update-one.sh:4] SCRIPT_DIR=/zfs/build/repo-build/pkgctl-version
+ [1774029284.189586] [3700573:update-one.sh:6] repo=pacbrew-staging
+ [1774029284.189613] [3700573:update-one.sh:7] universe=pacbrew,pacbrew-testing,pacbrew-staging
+ [1774029284.189659] [3700573:update-one.sh:9] '[' 1 -lt 1 ']'
+ [1774029284.189691] [3700573:update-one.sh:15] srcdir=../../pacbrew-repo/sdk
++ [1774029284.190007] [3700573:update-one.sh:16] dirname ../../pacbrew-repo/sdk
+ [1774029284.190570] [3700573:update-one.sh:16] repodir=../../pacbrew-repo
+ [1774029284.190647] [3700573:update-one.sh:20] mapfile -t pkgnames
++ [1774029284.190981] [3700573:update-one.sh:20] awk '/^pkgname = / { print $3 }' ../../pacbrew-repo/sdk/.SRCINFO
+ [1774029284.192792] [3700573:update-one.sh:21] read -r pkgver
++ [1774029284.193166] [3700573:update-one.sh:21] awk '/pkgver = /  { print $3 }' ../../pacbrew-repo/sdk/.SRCINFO
+ [1774029284.195129] [3700573:update-one.sh:23] mapfile -t -d ' ' -s 1 revdeps
++ [1774029284.195476] [3700573:update-one.sh:23] arch-rebuild-order --repos=pacbrew,pacbrew-testing,pacbrew-staging ps5-payload-sdk
+ [1774029284.205412] [3700573:update-one.sh:26] mapfile -t buildme
++ [1774029284.206531] [3700573:update-one.sh:26] awk -v repodir=../../pacbrew-repo $'!seen[$0]++ { \n\t\tsub(/^ps5-payload-/, "")\n\t\tprintf("%s/%s\\n", repodir, $0)\n\t}'
++ [1774029284.206545] [3700573:update-one.sh:26] expac -S %e ps5-payload-zlib ps5-payload-xz ps5-payload-wolfssl ps5-payload-sqlite ps5-payload-shsrv ps5-payload-opus ps5-payload-openssl ps5-payload-openlibm ps5-payload-mpg123 ps5-payload-miniupnpc ps5-payload-mbedtls ps5-payload-lz4 ps5-payload-lua ps5-payload-libxml2 ps5-payload-libwebp ps5-payload-libssh2 ps5-payload-libssh ps5-payload-libsodium ps5-payload-libsmb2 ps5-payload-libsamplerate ps5-payload-libressl ps5-payload-libpsl ps5-payload-libpng ps5-payload-libogg ps5-payload-libtheora ps5-payload-libnfs ps5-payload-libmpeg2 ps5-payload-libmicrohttpd ps5-payload-libmicrodns ps5-payload-websrv ps5-payload-libjpeg-turbo ps5-payload-libiconv ps5-payload-libfribidi ps5-payload-libevent ps5-payload-libdeflate ps5-payload-libcxx ps5-payload-zstd ps5-payload-tinyxml2 ps5-payload-sdl2 ps5-payload-sdl2_net ps5-payload-sdl2_mixer ps5-payload-sdl2_image ps5-payload-openal ps5-payload-luajit ps5-payload-llvm ps5-payload-libyuv ps5-payload-libvpx ps5-payload-libvorbis ps5-payload-libmad ps5-payload-libconfig ps5-payload-lame ps5-payload-lakesnes ps5-payload-klogsrv ps5-payload-json-c ps5-payload-jansson ps5-payload-imgui ps5-payload-glm ps5-payload-giflib ps5-payload-gdbsrv ps5-payload-ftpsrv ps5-payload-flac ps5-payload-mednafen ps5-payload-libsndfile ps5-payload-fbneo ps5-payload-fast_float ps5-payload-faad2 ps5-payload-expat ps5-payload-mesa ps5-payload-glu ps5-payload-osmesa ps5-payload-glew ps5-payload-enet ps5-payload-elfldr ps5-payload-eduke32 ps5-payload-curl ps5-payload-bzip2 ps5-payload-libzip ps5-payload-libarchive ps5-payload-freetype ps5-payload-harfbuzz ps5-payload-sdl2_ttf ps5-payload-offact ps5-payload-lbreakouthd ps5-payload-fontconfig ps5-payload-libass ps5-payload-ffmpeg ps5-payload-sdl2_kitchensink ps5-payload-file ps5-payload-devilutionx ps5-payload-bearssl ps5-payload-a52dec $'ps5-payload-scummvm\n'
+ [1774029284.427597] [3700573:update-one.sh:34] skipped=()
+ [1774029284.427903] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.427934] [3700573:update-one.sh:37] echo ../../pacbrew-repo/zlib
../../pacbrew-repo/zlib
+ [1774029284.427977] [3700573:update-one.sh:38] continue
+ [1774029284.428005] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428025] [3700573:update-one.sh:37] echo ../../pacbrew-repo/xz
../../pacbrew-repo/xz
+ [1774029284.428054] [3700573:update-one.sh:38] continue
+ [1774029284.428071] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428090] [3700573:update-one.sh:37] echo ../../pacbrew-repo/wolfssl
../../pacbrew-repo/wolfssl
+ [1774029284.428110] [3700573:update-one.sh:38] continue
+ [1774029284.428126] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428143] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sqlite
../../pacbrew-repo/sqlite
+ [1774029284.428165] [3700573:update-one.sh:38] continue
+ [1774029284.428176] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428188] [3700573:update-one.sh:37] echo ../../pacbrew-repo/shsrv
../../pacbrew-repo/shsrv
+ [1774029284.428201] [3700573:update-one.sh:38] continue
+ [1774029284.428211] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428222] [3700573:update-one.sh:37] echo ../../pacbrew-repo/opus
../../pacbrew-repo/opus
+ [1774029284.428234] [3700573:update-one.sh:38] continue
+ [1774029284.428245] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428273] [3700573:update-one.sh:37] echo ../../pacbrew-repo/openssl
../../pacbrew-repo/openssl
+ [1774029284.428292] [3700573:update-one.sh:38] continue
+ [1774029284.428308] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428329] [3700573:update-one.sh:37] echo ../../pacbrew-repo/openlibm
../../pacbrew-repo/openlibm
+ [1774029284.428351] [3700573:update-one.sh:38] continue
+ [1774029284.428370] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428390] [3700573:update-one.sh:37] echo ../../pacbrew-repo/mpg123
../../pacbrew-repo/mpg123
+ [1774029284.428410] [3700573:update-one.sh:38] continue
+ [1774029284.428427] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428446] [3700573:update-one.sh:37] echo ../../pacbrew-repo/miniupnpc
../../pacbrew-repo/miniupnpc
+ [1774029284.428468] [3700573:update-one.sh:38] continue
+ [1774029284.428484] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428502] [3700573:update-one.sh:37] echo ../../pacbrew-repo/mbedtls
../../pacbrew-repo/mbedtls
+ [1774029284.428523] [3700573:update-one.sh:38] continue
+ [1774029284.428540] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428580] [3700573:update-one.sh:37] echo ../../pacbrew-repo/lz4
../../pacbrew-repo/lz4
+ [1774029284.428602] [3700573:update-one.sh:38] continue
+ [1774029284.428619] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428637] [3700573:update-one.sh:37] echo ../../pacbrew-repo/lua
../../pacbrew-repo/lua
+ [1774029284.428658] [3700573:update-one.sh:38] continue
+ [1774029284.428675] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428693] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libxml2
../../pacbrew-repo/libxml2
+ [1774029284.428713] [3700573:update-one.sh:38] continue
+ [1774029284.428730] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428747] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libwebp
../../pacbrew-repo/libwebp
+ [1774029284.428766] [3700573:update-one.sh:38] continue
+ [1774029284.428785] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428797] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libssh2
../../pacbrew-repo/libssh2
+ [1774029284.428809] [3700573:update-one.sh:38] continue
+ [1774029284.428819] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428831] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libssh
../../pacbrew-repo/libssh
+ [1774029284.428843] [3700573:update-one.sh:38] continue
+ [1774029284.428853] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428864] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libsodium
../../pacbrew-repo/libsodium
+ [1774029284.428878] [3700573:update-one.sh:38] continue
+ [1774029284.428888] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428899] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libsmb2
../../pacbrew-repo/libsmb2
+ [1774029284.428912] [3700573:update-one.sh:38] continue
+ [1774029284.428923] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428934] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libsamplerate
../../pacbrew-repo/libsamplerate
+ [1774029284.428947] [3700573:update-one.sh:38] continue
+ [1774029284.428958] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.428969] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libressl
../../pacbrew-repo/libressl
+ [1774029284.428982] [3700573:update-one.sh:38] continue
+ [1774029284.428993] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429004] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libpsl
../../pacbrew-repo/libpsl
+ [1774029284.429017] [3700573:update-one.sh:38] continue
+ [1774029284.429027] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429038] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libpng
../../pacbrew-repo/libpng
+ [1774029284.429051] [3700573:update-one.sh:38] continue
+ [1774029284.429062] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429073] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libogg
../../pacbrew-repo/libogg
+ [1774029284.429085] [3700573:update-one.sh:38] continue
+ [1774029284.429095] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429106] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libtheora
../../pacbrew-repo/libtheora
+ [1774029284.429120] [3700573:update-one.sh:38] continue
+ [1774029284.429131] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429142] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libnfs
../../pacbrew-repo/libnfs
+ [1774029284.429154] [3700573:update-one.sh:38] continue
+ [1774029284.429165] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429176] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libmpeg2
../../pacbrew-repo/libmpeg2
+ [1774029284.429189] [3700573:update-one.sh:38] continue
+ [1774029284.429199] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429211] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libmicrohttpd
../../pacbrew-repo/libmicrohttpd
+ [1774029284.429224] [3700573:update-one.sh:38] continue
+ [1774029284.429234] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429245] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libmicrodns
../../pacbrew-repo/libmicrodns
+ [1774029284.429258] [3700573:update-one.sh:38] continue
+ [1774029284.429268] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429279] [3700573:update-one.sh:37] echo ../../pacbrew-repo/websrv
../../pacbrew-repo/websrv
+ [1774029284.429292] [3700573:update-one.sh:38] continue
+ [1774029284.429303] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429314] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libjpeg-turbo
../../pacbrew-repo/libjpeg-turbo
+ [1774029284.429327] [3700573:update-one.sh:38] continue
+ [1774029284.429337] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429349] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libiconv
../../pacbrew-repo/libiconv
+ [1774029284.429369] [3700573:update-one.sh:38] continue
+ [1774029284.429428] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429440] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libfribidi
../../pacbrew-repo/libfribidi
+ [1774029284.429453] [3700573:update-one.sh:38] continue
+ [1774029284.429464] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429475] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libevent
../../pacbrew-repo/libevent
+ [1774029284.429488] [3700573:update-one.sh:38] continue
+ [1774029284.429499] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429510] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libdeflate
../../pacbrew-repo/libdeflate
+ [1774029284.429523] [3700573:update-one.sh:38] continue
+ [1774029284.429533] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429545] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libcxx
../../pacbrew-repo/libcxx
+ [1774029284.429558] [3700573:update-one.sh:38] continue
+ [1774029284.429568] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429579] [3700573:update-one.sh:37] echo ../../pacbrew-repo/zstd
../../pacbrew-repo/zstd
+ [1774029284.429609] [3700573:update-one.sh:38] continue
+ [1774029284.429626] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429645] [3700573:update-one.sh:37] echo ../../pacbrew-repo/tinyxml2
../../pacbrew-repo/tinyxml2
+ [1774029284.429666] [3700573:update-one.sh:38] continue
+ [1774029284.429683] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429702] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sdl2
../../pacbrew-repo/sdl2
+ [1774029284.429723] [3700573:update-one.sh:38] continue
+ [1774029284.429740] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429759] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sdl2_net
../../pacbrew-repo/sdl2_net
+ [1774029284.429780] [3700573:update-one.sh:38] continue
+ [1774029284.429797] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429815] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sdl2_mixer
../../pacbrew-repo/sdl2_mixer
+ [1774029284.429837] [3700573:update-one.sh:38] continue
+ [1774029284.429854] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429891] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sdl2_image
../../pacbrew-repo/sdl2_image
+ [1774029284.429912] [3700573:update-one.sh:38] continue
+ [1774029284.429929] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.429948] [3700573:update-one.sh:37] echo ../../pacbrew-repo/openal
../../pacbrew-repo/openal
+ [1774029284.429969] [3700573:update-one.sh:38] continue
+ [1774029284.429986] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430004] [3700573:update-one.sh:37] echo ../../pacbrew-repo/luajit
../../pacbrew-repo/luajit
+ [1774029284.430024] [3700573:update-one.sh:38] continue
+ [1774029284.430042] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430061] [3700573:update-one.sh:37] echo ../../pacbrew-repo/llvm
../../pacbrew-repo/llvm
+ [1774029284.430080] [3700573:update-one.sh:38] continue
+ [1774029284.430096] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430114] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libyuv
../../pacbrew-repo/libyuv
+ [1774029284.430141] [3700573:update-one.sh:38] continue
+ [1774029284.430150] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430162] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libvpx
../../pacbrew-repo/libvpx
+ [1774029284.430174] [3700573:update-one.sh:38] continue
+ [1774029284.430198] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430217] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libvorbis
../../pacbrew-repo/libvorbis
+ [1774029284.430251] [3700573:update-one.sh:38] continue
+ [1774029284.430268] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430291] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libmad
../../pacbrew-repo/libmad
+ [1774029284.430305] [3700573:update-one.sh:38] continue
+ [1774029284.430315] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430326] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libconfig
../../pacbrew-repo/libconfig
+ [1774029284.430339] [3700573:update-one.sh:38] continue
+ [1774029284.430349] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430360] [3700573:update-one.sh:37] echo ../../pacbrew-repo/lame
../../pacbrew-repo/lame
+ [1774029284.430373] [3700573:update-one.sh:38] continue
+ [1774029284.430383] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430394] [3700573:update-one.sh:37] echo ../../pacbrew-repo/lakesnes
../../pacbrew-repo/lakesnes
+ [1774029284.430407] [3700573:update-one.sh:38] continue
+ [1774029284.430417] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430428] [3700573:update-one.sh:37] echo ../../pacbrew-repo/klogsrv
../../pacbrew-repo/klogsrv
+ [1774029284.430441] [3700573:update-one.sh:38] continue
+ [1774029284.430451] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430462] [3700573:update-one.sh:37] echo ../../pacbrew-repo/json-c
../../pacbrew-repo/json-c
+ [1774029284.430476] [3700573:update-one.sh:38] continue
+ [1774029284.430486] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430498] [3700573:update-one.sh:37] echo ../../pacbrew-repo/jansson
../../pacbrew-repo/jansson
+ [1774029284.430511] [3700573:update-one.sh:38] continue
+ [1774029284.430521] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430532] [3700573:update-one.sh:37] echo ../../pacbrew-repo/imgui
../../pacbrew-repo/imgui
+ [1774029284.430545] [3700573:update-one.sh:38] continue
+ [1774029284.430555] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430566] [3700573:update-one.sh:37] echo ../../pacbrew-repo/glm
../../pacbrew-repo/glm
+ [1774029284.430579] [3700573:update-one.sh:38] continue
+ [1774029284.430589] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430601] [3700573:update-one.sh:37] echo ../../pacbrew-repo/giflib
../../pacbrew-repo/giflib
+ [1774029284.430614] [3700573:update-one.sh:38] continue
+ [1774029284.430624] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430635] [3700573:update-one.sh:37] echo ../../pacbrew-repo/gdbsrv
../../pacbrew-repo/gdbsrv
+ [1774029284.430648] [3700573:update-one.sh:38] continue
+ [1774029284.430658] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430670] [3700573:update-one.sh:37] echo ../../pacbrew-repo/ftpsrv
../../pacbrew-repo/ftpsrv
+ [1774029284.430682] [3700573:update-one.sh:38] continue
+ [1774029284.430692] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430704] [3700573:update-one.sh:37] echo ../../pacbrew-repo/flac
../../pacbrew-repo/flac
+ [1774029284.430716] [3700573:update-one.sh:38] continue
+ [1774029284.430726] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430738] [3700573:update-one.sh:37] echo ../../pacbrew-repo/mednafen
../../pacbrew-repo/mednafen
+ [1774029284.430751] [3700573:update-one.sh:38] continue
+ [1774029284.430761] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430772] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libsndfile
../../pacbrew-repo/libsndfile
+ [1774029284.430786] [3700573:update-one.sh:38] continue
+ [1774029284.430796] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430807] [3700573:update-one.sh:37] echo ../../pacbrew-repo/fbneo
../../pacbrew-repo/fbneo
+ [1774029284.430820] [3700573:update-one.sh:38] continue
+ [1774029284.430830] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430842] [3700573:update-one.sh:37] echo ../../pacbrew-repo/fast_float
../../pacbrew-repo/fast_float
+ [1774029284.430854] [3700573:update-one.sh:38] continue
+ [1774029284.430865] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430876] [3700573:update-one.sh:37] echo ../../pacbrew-repo/faad2
../../pacbrew-repo/faad2
+ [1774029284.430889] [3700573:update-one.sh:38] continue
+ [1774029284.430899] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430910] [3700573:update-one.sh:37] echo ../../pacbrew-repo/expat
../../pacbrew-repo/expat
+ [1774029284.430924] [3700573:update-one.sh:38] continue
+ [1774029284.430935] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430947] [3700573:update-one.sh:37] echo ../../pacbrew-repo/mesa
../../pacbrew-repo/mesa
+ [1774029284.430959] [3700573:update-one.sh:38] continue
+ [1774029284.430970] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.430981] [3700573:update-one.sh:37] echo ../../pacbrew-repo/glu
../../pacbrew-repo/glu
+ [1774029284.430994] [3700573:update-one.sh:38] continue
+ [1774029284.431004] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431016] [3700573:update-one.sh:37] echo ../../pacbrew-repo/osmesa
../../pacbrew-repo/osmesa
+ [1774029284.431028] [3700573:update-one.sh:38] continue
+ [1774029284.431038] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431050] [3700573:update-one.sh:37] echo ../../pacbrew-repo/glew
../../pacbrew-repo/glew
+ [1774029284.431062] [3700573:update-one.sh:38] continue
+ [1774029284.431073] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431084] [3700573:update-one.sh:37] echo ../../pacbrew-repo/enet
../../pacbrew-repo/enet
+ [1774029284.431098] [3700573:update-one.sh:38] continue
+ [1774029284.431108] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431119] [3700573:update-one.sh:37] echo ../../pacbrew-repo/elfldr
../../pacbrew-repo/elfldr
+ [1774029284.431132] [3700573:update-one.sh:38] continue
+ [1774029284.431143] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431154] [3700573:update-one.sh:37] echo ../../pacbrew-repo/eduke32
../../pacbrew-repo/eduke32
+ [1774029284.431167] [3700573:update-one.sh:38] continue
+ [1774029284.431177] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431188] [3700573:update-one.sh:37] echo ../../pacbrew-repo/curl
../../pacbrew-repo/curl
+ [1774029284.431201] [3700573:update-one.sh:38] continue
+ [1774029284.431211] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431222] [3700573:update-one.sh:37] echo ../../pacbrew-repo/bzip2
../../pacbrew-repo/bzip2
+ [1774029284.431235] [3700573:update-one.sh:38] continue
+ [1774029284.431246] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431257] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libzip
../../pacbrew-repo/libzip
+ [1774029284.431271] [3700573:update-one.sh:38] continue
+ [1774029284.431282] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431293] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libarchive
../../pacbrew-repo/libarchive
+ [1774029284.431306] [3700573:update-one.sh:38] continue
+ [1774029284.431317] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431328] [3700573:update-one.sh:37] echo ../../pacbrew-repo/freetype
../../pacbrew-repo/freetype
+ [1774029284.431341] [3700573:update-one.sh:38] continue
+ [1774029284.431351] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431363] [3700573:update-one.sh:37] echo ../../pacbrew-repo/harfbuzz
../../pacbrew-repo/harfbuzz
+ [1774029284.431376] [3700573:update-one.sh:38] continue
+ [1774029284.431386] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431398] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sdl2_ttf
../../pacbrew-repo/sdl2_ttf
+ [1774029284.431411] [3700573:update-one.sh:38] continue
+ [1774029284.431421] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431432] [3700573:update-one.sh:37] echo ../../pacbrew-repo/offact
../../pacbrew-repo/offact
+ [1774029284.431445] [3700573:update-one.sh:38] continue
+ [1774029284.431456] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431467] [3700573:update-one.sh:37] echo ../../pacbrew-repo/lbreakouthd
../../pacbrew-repo/lbreakouthd
+ [1774029284.431480] [3700573:update-one.sh:38] continue
+ [1774029284.431490] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431502] [3700573:update-one.sh:37] echo ../../pacbrew-repo/fontconfig
../../pacbrew-repo/fontconfig
+ [1774029284.431515] [3700573:update-one.sh:38] continue
+ [1774029284.431526] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431537] [3700573:update-one.sh:37] echo ../../pacbrew-repo/libass
../../pacbrew-repo/libass
+ [1774029284.431551] [3700573:update-one.sh:38] continue
+ [1774029284.431561] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431572] [3700573:update-one.sh:37] echo ../../pacbrew-repo/ffmpeg
../../pacbrew-repo/ffmpeg
+ [1774029284.431585] [3700573:update-one.sh:38] continue
+ [1774029284.431595] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431607] [3700573:update-one.sh:37] echo ../../pacbrew-repo/sdl2_kitchensink
../../pacbrew-repo/sdl2_kitchensink
+ [1774029284.431620] [3700573:update-one.sh:38] continue
+ [1774029284.431631] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431642] [3700573:update-one.sh:37] echo ../../pacbrew-repo/file
../../pacbrew-repo/file
+ [1774029284.431655] [3700573:update-one.sh:38] continue
+ [1774029284.431665] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431676] [3700573:update-one.sh:37] echo ../../pacbrew-repo/devilutionx
../../pacbrew-repo/devilutionx
+ [1774029284.431690] [3700573:update-one.sh:38] continue
+ [1774029284.431700] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431711] [3700573:update-one.sh:37] echo ../../pacbrew-repo/bearssl
../../pacbrew-repo/bearssl
+ [1774029284.431736] [3700573:update-one.sh:38] continue
+ [1774029284.431753] [3700573:update-one.sh:35] for p in "${buildme[@]}"
+ [1774029284.431772] [3700573:update-one.sh:37] echo ../../pacbrew-repo/a52dec
../../pacbrew-repo/a52dec
+ [1774029284.431793] [3700573:update-one.sh:38] continue
